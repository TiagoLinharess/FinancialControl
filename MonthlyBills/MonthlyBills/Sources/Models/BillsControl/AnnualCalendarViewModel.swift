//
//  AnnualCalendarViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
import Foundation
import SharpnezCore

class AnnualCalendarViewModel {
    
    // MARK: Properties
    
    let year: String
    private(set) var monthlyBills: [MonthlyBillViewModel]
    
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
        self.monthlyBills = Calendar.current.monthSymbols.map { month -> MonthlyBillViewModel in
            return .init(month: month)
        }
    }
    
    // MARK: Methods
    
    func set(bill: MonthlyBillViewModel, at index: Int) throws {
        if index > 11 || index < 0 {
            throw CoreError.customError(CoreConstants.Error.indexOutOfBounds)
        }
        
        monthlyBills[index] = bill
    }
}
