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
    
    func createBillItem(item: MonthlyBills.BillItemProtocol, billId: String, billType: MonthlyBills.BillType) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func createTemplateItem(item: BillItemProtocol, billType: BillType) throws {
        if isError {
            throw CoreError.customError("test error")
        }
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
    
    func readTemplates() throws -> [BillSectionViewModel] {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return [BillsMock.expenseSection]
    }
    
    func readTemplateAt(id: String) throws -> BillItemProtocol {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return BillsMock.item
    }
    
    func updateBillItem(item: MonthlyBills.BillItemProtocol, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateTemplateItem(item: BillItemProtocol) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func deleteItem(itemId: String, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func deleteTemplateItem(itemId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
}
