//
//  MonthlyBillsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation
import SharpnezCore

public protocol MonthlyBillsRepositoryProtocol {
    func create(annualCalendar: AnnualCalendarResponse) throws
    func read() throws -> [AnnualCalendarResponse]
    func readAtYear(year: String) throws -> AnnualCalendarResponse
    func readAtMonth(id: String) throws -> MonthlyBillsResponse
}

public final class MonthlyBillsRepository: MonthlyBillsRepositoryProtocol {
    
    let key: String
    
    public init(key: String? = nil) {
        self.key = key ?? Constants.UserDefaultsKeys.bills
    }
    
    // MARK: Create
    
    public func create(annualCalendar: AnnualCalendarResponse) throws {
        var currentCalendars = try read()
        
        if compareCalendars(calendar: annualCalendar, currentCalendars: currentCalendars) {
            throw CoreError.customError(Constants.MonthlyBillsRepository.existentCalendar)
        }
        
        currentCalendars.insert(annualCalendar, at: .zero)
        
        let data = try JSONEncoder().encode(currentCalendars)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Read
    
    public func read() throws -> [AnnualCalendarResponse] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let response = try JSONDecoder().decode([AnnualCalendarResponse].self, from: data)
        return response
    }
    
    public func readAtYear(year: String) throws -> AnnualCalendarResponse {
        let currentCalendars = try read()
        
        guard let calendar = currentCalendars.first(where: { calendar in
            calendar.year == year
        }) else {
            throw CoreError.customError(Constants.MonthlyBillsRepository.calendarNotFound)
        }
        
        return calendar
    }
    
    public func readAtMonth(id: String) throws -> MonthlyBillsResponse {
        let calendars = try read()
        
        for calendar in calendars {
            if let bill = calendar.monthlyBills.first(where: { $0.id == id }) {
                return bill
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
    }
}

private extension MonthlyBillsRepository {
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
        }
    }
}
