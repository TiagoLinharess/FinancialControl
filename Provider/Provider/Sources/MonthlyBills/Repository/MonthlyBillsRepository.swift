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
    func updateIncome(response: IncomeResponse, billId: String) throws
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
    
    // MARK: Update
    
    public func updateIncome(response: IncomeResponse, billId: String) throws {
        var calendars = try read()
        let (calendarIndex, billIndex) = try findCalendarAndBillIndices(for: billId)
        
        calendars[calendarIndex].monthlyBills[billIndex].income = response
        
        let data = try JSONEncoder().encode(calendars)
        UserDefaults.standard.set(data, forKey: key)
    }
}

private extension MonthlyBillsRepository {
    
    // MARK: Private Methods
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
        }
    }
    
    func findCalendarAndBillIndices(for billId: String) throws -> (calendarIndex: Int, billIndex: Int) {
        let calendars = try read()
        
        for (calendarIndex, calendar) in calendars.enumerated() {
            if let billIndex = calendar.monthlyBills.firstIndex(where: { $0.id == billId }) {
                return (calendarIndex, billIndex)
            }
        }
        
        throw CoreError.customError(Constants.MonthlyBillsRepository.billNotFound)
    }
}
