//
//  BillsMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

import Foundation
@testable import MonthlyBills
import SharpnezCore

struct BillsMock {
    
    static var expense = BillItemViewModel(id: "BillExpenseItemViewModel", name: "iphone", value: 100, status: .pending, installment: .init(current: 5, max: 6))
    
    static var investment = BillItemViewModel(id: "BillInvestmentItemViewModel", name: "share", value: 10, status: .payed, installment: nil)
    
    static var income = BillIncomeItemViewModel(id: "BillIncomeItemViewModel", name: "salary", value: 3000, status: .payed)
    
    static var billIncomplete = MonthlyBillsViewModel(month: "January")
    
    static var billComplete = MonthlyBillsViewModel(month: "January", incomes: [income], investments: [investment], expenses: [expense])
    
    static var annualCalendar = AnnualCalendarViewModel(year: "2023")
    
    static var billCompleteId: String {
        return billComplete.id
    }
    
    static var billIncompleteId: String {
        return billIncomplete.id
    }
}
