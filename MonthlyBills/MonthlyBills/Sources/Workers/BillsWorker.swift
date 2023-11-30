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
    func create(annualBills: AnnualBillsViewModel) throws
    func read() throws -> [AnnualBillsViewModel]
}

final class BillsWorker: BillsWorking {
    
    // MARK: Create
    
    func create(annualBills: AnnualBillsViewModel) throws {
        // todo
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualBillsViewModel] {
        return []
    }
}
