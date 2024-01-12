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
    
    static var expense = ExpenseViewModel(housing: 200, transport: 100, feed: 20, health: 40, education: 200, taxes: 300, laisure: 10, clothing: 10, creditCard: 2000, other: 0)
    
    static var investment = InvestmentViewModel(shares: 100, privatePension: 0, fixedIncome: 200, other: 0)
    
    static var income = IncomeViewModel(salary: 5000, bonus: 200, extra: 0, other: 0)
    
    static var billIncomplete = MonthlyBillsViewModel(month: "January")
    
    static var billComplete = MonthlyBillsViewModel(month: "January", income: income, investment: investment, expense: expense)
    
    static var annualCalendar = AnnualCalendarViewModel(year: "2023")
    
    static var billCompleteId: String {
        return billComplete.id
    }
    
    static var billIncompleteId: String {
        return billIncomplete.id
    }
}
