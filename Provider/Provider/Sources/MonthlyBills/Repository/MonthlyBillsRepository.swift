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
}

private extension MonthlyBillsRepository {
    
    func compareCalendars(calendar: AnnualCalendarResponse, currentCalendars: [AnnualCalendarResponse]) -> Bool {
        currentCalendars.contains { currentCalendar in
            return currentCalendar.year == calendar.year
        }
    }
}
