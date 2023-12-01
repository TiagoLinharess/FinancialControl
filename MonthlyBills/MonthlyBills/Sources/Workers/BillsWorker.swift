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
}
