//
//  AnnualCalendarViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
import Foundation
import Provider
import SharpnezCore

class AnnualCalendarViewModel {
    
    // MARK: Properties
    
    let year: String
    private(set) var monthlyBills: [MonthlyBillsViewModel]
    
    var balance: Double {
        var balance: Double = .zero
        
        monthlyBills.forEach { bill in
            balance += bill.balance
        }
        
        return balance
    }
    
    // MARK: Init
    
    init(year: String) {
        self.year = year
        self.monthlyBills = Calendar.current.monthSymbols.map { month -> MonthlyBillsViewModel in
            return .init(month: month)
        }
    }
    
    // MARK: Init from response
    
    init(from response: AnnualCalendarResponse) {
        self.year = response.year
        self.monthlyBills = response.monthlyBills.map { .init(from: $0) }
    }
    
    // MARK: Methods
    
    func set(bill: MonthlyBillsViewModel, at index: Int) throws {
        if index > 11 || index < 0 {
            throw CoreError.customError(CoreConstants.Error.indexOutOfBounds)
        }
        
        monthlyBills[index] = bill
    }
    
    func getResponse() -> AnnualCalendarResponse {
        return .init(year: year, monthlyBills: monthlyBills.map { $0.getResponse() })
    }
}
