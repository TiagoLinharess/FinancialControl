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
    
    func readNotes(at key: MonthlyBills.BillsNotesKey) throws -> String {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return "test notes key \(key)"
    }
    
    func updateIncome(incomeViewModel: MonthlyBills.IncomeViewModel, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateInvestment(investmentViewModel: MonthlyBills.InvestmentViewModel, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateExpense(expenseViewModel: MonthlyBills.ExpenseViewModel, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateNotes(notes: String, for key: MonthlyBills.BillsNotesKey) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
}
