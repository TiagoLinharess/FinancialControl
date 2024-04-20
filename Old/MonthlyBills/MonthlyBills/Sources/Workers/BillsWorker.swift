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
    func createCalendar(annualCalendar: AnnualCalendarViewModel) throws
    func createBillItem(item: BillItemProtocol, billId: String, billType: BillType) throws
    func createTemplateItem(item: BillItemProtocol, billType: BillType) throws
    func readCalendar() throws -> [AnnualCalendarViewModel]
    func readAtYear(year: String) throws -> AnnualCalendarViewModel
    func readAtMonth(id: String) throws -> MonthlyBillsViewModel
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsViewModel
    func readTemplates() throws -> [BillSectionViewModel]
    func readTemplateAt(id: String) throws -> BillItemProtocol
    func updateBillItem(item: BillItemProtocol, billId: String) throws
    func updateTemplateItem(item: BillItemProtocol) throws
    func deleteItem(itemId: String, billId: String) throws
    func deleteTemplateItem(itemId: String) throws
}

final class BillsWorker: BillsWorking {
    
    // MARK: Properties
    
    let repository: MonthlyBillsProviderProtocol
    
    // MARK: Init
    
    init(repository: MonthlyBillsProviderProtocol = MonthlyBillsProvider()) {
        self.repository = repository
    }
    
    // MARK: Create
    
    func createCalendar(annualCalendar: AnnualCalendarViewModel) throws {
        try repository.createCalendar(annualCalendar: annualCalendar.getResponse())
    }
    
    func createBillItem(item: BillItemProtocol, billId: String, billType: BillType) throws {
        try repository.createBillItem(item: item.getResponse(), billId: billId, billType: billType.getResponse())
    }
    
    func createTemplateItem(item: BillItemProtocol, billType: BillType) throws {
        try repository.createTemplateItem(item: item.getResponse(), billType: billType.getResponse())
    }
    
    // MARK: Read
    
    func readCalendar() throws -> [AnnualCalendarViewModel] {
        let annualCalendars = try repository.readCalendar()
        
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
    
    func readAtMonthWithTemplates(billId: String) throws -> MonthlyBillsViewModel {
        return try .init(from: repository.readAtMonthWithTemplates(billId: billId))
    }
    
    func readTemplates() throws -> [BillSectionViewModel] {
        let templates = try repository.readTemplates()
        
        return templates.map { response -> BillSectionViewModel in
            return .init(from: response)
        }
    }
    
    func readTemplateAt(id: String) throws -> BillItemProtocol {
        return try BillItemViewModel(from: repository.readTemplateAt(id: id))
    }
    
    // MARK: Update
    
    func updateBillItem(item: BillItemProtocol, billId: String) throws {
        try repository.updateBillItem(item: item.getResponse(), billId: billId)
    }
    
    func updateTemplateItem(item: BillItemProtocol) throws {
        try repository.updateTemplateItem(item: item.getResponse())
    }
    
    // MARK: Delete
    
    func deleteItem(itemId: String, billId: String) throws {
        try repository.deleteItem(itemId: itemId, billId: billId)
    }
    
    func deleteTemplateItem(itemId: String) throws {
        try repository.deleteTemplateItem(itemId: itemId)
    }
}
