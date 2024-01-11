//
//  MonthlyBillsRepositoryMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 08/01/24.
//

import Foundation
import Provider
import SharpnezCore

final class MonthlyBillsRepositoryMock: MonthlyBillsRepositoryProtocol {
    
    lazy var billId = UUID().uuidString
    
    private lazy var monthlyBillsMock: MonthlyBillsResponse = .init(id: billId, month: "January", income: nil, investment: nil, expense: nil)
    
    private lazy var annualCalendarMock: AnnualCalendarResponse = .init(year: "2024", monthlyBills: [monthlyBillsMock])
    
    var isError: Bool = false
    
    func create(annualCalendar: Provider.AnnualCalendarResponse) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func read() throws -> [Provider.AnnualCalendarResponse] {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return [annualCalendarMock]
    }
    
    func readAtYear(year: String) throws -> Provider.AnnualCalendarResponse {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return annualCalendarMock
    }
    
    func readAtMonth(id: String) throws -> Provider.MonthlyBillsResponse {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return monthlyBillsMock
    }
    
    func readNotes(at key: String) throws -> String {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return "test notes key \(key)"
    }
    
    func updateIncome(response: Provider.IncomeResponse, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateInvestment(response: Provider.InvestmentResponse, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateExpense(response: Provider.ExpenseResponse, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func updateNotes(notes: String, for key: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
}
