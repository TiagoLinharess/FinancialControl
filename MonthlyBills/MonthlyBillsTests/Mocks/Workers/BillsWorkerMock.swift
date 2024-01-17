//
//  BillsWorkerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import UIKit

final class BillsWorkerMock: BillsWorking {
    
    var isError: Bool = false
    
    func create(annualCalendar: MonthlyBills.AnnualCalendarViewModel) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func createBillItem() throws {
        // todo
    }
    
    func read() throws -> [MonthlyBills.AnnualCalendarViewModel] {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return [BillsMock.annualCalendar]
    }
    
    func readAtYear(year: String) throws -> MonthlyBills.AnnualCalendarViewModel {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return BillsMock.annualCalendar
    }
    
    func readAtMonth(id: String) throws -> MonthlyBills.MonthlyBillsViewModel {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return BillsMock.billIncomplete
    }
    
    func updateBillItem(at itemToEdit: EditBillItemViewModel, item: BillItemProtocol) {
        // todo
    }
}
