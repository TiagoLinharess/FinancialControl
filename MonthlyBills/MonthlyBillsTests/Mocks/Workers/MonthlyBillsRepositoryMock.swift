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
    
    private lazy var monthlyBillsMock: MonthlyBillsResponse = .init(id: billId, month: "January", sections: [])
    
    private lazy var annualCalendarMock: AnnualCalendarResponse = .init(year: "2024", monthlyBills: [monthlyBillsMock])
    
    var isError: Bool = false
    
    func create(annualCalendar: Provider.AnnualCalendarResponse) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func createBillItem(item: Provider.BillItemResponse, billId: String, billType: Provider.BillSectionResponse.BillType) throws {
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
    
    func updateBillItem(item: Provider.BillItemResponse, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func deleteItem(itemId: String, billId: String) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
}
