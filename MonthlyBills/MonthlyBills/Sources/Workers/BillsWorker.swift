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
    func createBillItem(item: BillItemProtocol, billId: String, billType: BillType) throws
    func read() throws -> [AnnualCalendarViewModel]
    func readAtYear(year: String) throws -> AnnualCalendarViewModel
    func readAtMonth(id: String) throws -> MonthlyBillsViewModel
    func updateBillItem(item: BillItemProtocol, billId: String) throws
    func deleteItem(itemId: String, billId: String) throws
}

final class BillsWorker: BillsWorking {
    
    // MARK: Properties
    
    let repository: MonthlyBillsRepositoryProtocol
    
    // MARK: Init
    
    init(repository: MonthlyBillsRepositoryProtocol = MonthlyBillsRepository()) {
        self.repository = repository
    }
    
    // MARK: Create
    
    func create(annualCalendar: AnnualCalendarViewModel) throws {
        try repository.create(annualCalendar: annualCalendar.getResponse())
    }
    
    func createBillItem(item: BillItemProtocol, billId: String, billType: BillType) throws {
        try repository.createBillItem(item: item.getResponse(), billId: billId, billType: billType.getResponse())
    }
    
    // MARK: Read
    
    func read() throws -> [AnnualCalendarViewModel] {
        let annualCalendars = try repository.read()
        
        return annualCalendars.map { response -> AnnualCalendarViewModel in
            return .init(from: response)
        }
    }
    
    func readAtYear(year: String) throws -> AnnualCalendarViewModel {
        return try .init(from: repository.readAtYear(year: year))
    }
    
    func readAtMonth(id: String) throws -> MonthlyBillsViewModel {
        return try .init(from: repository.readAtMonth(id: id))
    }
    
    // MARK: Update
    
    func updateBillItem(item: BillItemProtocol, billId: String) throws {
        try repository.updateBillItem(item: item.getResponse(), billId: billId)
    }
    
    // MARK: Delete
    
    func deleteItem(itemId: String, billId: String) throws {
        try repository.deleteItem(itemId: itemId, billId: billId)
    }
}
