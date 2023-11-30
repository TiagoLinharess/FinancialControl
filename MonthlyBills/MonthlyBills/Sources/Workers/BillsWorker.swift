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
    
    // MARK: Create
    
    func create(annualCalendar: AnnualCalendarViewModel) throws {
        // todo
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualCalendarViewModel] {
        return []
    }
}
