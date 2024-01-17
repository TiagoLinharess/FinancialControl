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
    func createBillItem() throws
    func read() throws -> [AnnualCalendarViewModel]
    func readAtYear(year: String) throws -> AnnualCalendarViewModel
    func readAtMonth(id: String) throws -> MonthlyBillsViewModel
    func readNotes(at key: BillsNotesKey) throws -> String
    func updateBillItem(at itemToEdit: EditBillItemViewModel, item: BillItemProtocol)
    func updateNotes(notes: String, for key: BillsNotesKey) throws // todo
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
    
    func createBillItem() throws {
        // todo
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
    
    func readNotes(at key: BillsNotesKey) throws -> String {
        return try repository.readNotes(at: key.rawValue)
    }
    
    // MARK: Update
    
    func updateBillItem(at itemToEdit: EditBillItemViewModel, item: BillItemProtocol) {
        // todo
    }
    
    func updateNotes(notes: String, for key: BillsNotesKey) throws {
        try repository.updateNotes(notes: notes, for: key.rawValue)
    }
}
