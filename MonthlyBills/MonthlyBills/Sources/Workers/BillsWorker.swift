//
//  BillsWorker.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation
import Provider
import SharpnezCore

protocol BillsWorking {
    func create(annualCalendar: AnnualCalendarViewModel) throws
    func read() throws -> [AnnualCalendarViewModel]
    func readAt(year: String) throws -> AnnualCalendarViewModel
}

final class BillsWorker: BillsWorking {
    
    let repository: MonthlyBillsRepositoryProtocol
    
    init(repository: MonthlyBillsRepositoryProtocol = MonthlyBillsRepository()) {
        self.repository = repository
    }
    
    // MARK: Create
    
    func create(annualCalendar: AnnualCalendarViewModel) throws {
        try repository.create(annualCalendar: annualCalendar.getResponse())
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualCalendarViewModel] {
        let annualCalendars = try repository.read()
        
        return annualCalendars.map { response -> AnnualCalendarViewModel in
            return .init(from: response)
        }
    }
    
    func readAt(year: String) throws -> AnnualCalendarViewModel {
        let annualCalendars = try repository.read().map { response -> AnnualCalendarViewModel in
            return .init(from: response)
        }
        
        guard let calendar = annualCalendars.first(where: { calendar in
            calendar.year == year
        }) else {
            throw CoreError.customError("Could not find calendar")
        }
        
        return calendar
    }
}
