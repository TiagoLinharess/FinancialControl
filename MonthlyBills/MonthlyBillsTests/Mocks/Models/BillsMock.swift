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
    
    static var incomeSection = BillSectionViewModel(items: [incomeItem], type: .income)
    
    static var investmentSection = BillSectionViewModel(items: [item], type: .investment)
    
    static var expenseSection = BillSectionViewModel(items: [item], type: .expense)
    
    static var creditCardSection = BillSectionViewModel(items: [item], type: .creditCard)
    
    static var item = BillItemViewModel(id: "BillInvestmentItemViewModel", name: "share", value: 10, status: .payed, installment: nil)
    
    static var incomeItem = BillIncomeItemViewModel(id: "BillIncomeItemViewModel", name: "salary", value: 3000, status: .payed)
    
    static var billIncomplete = MonthlyBillsViewModel(month: "January")
    
    static var billComplete = MonthlyBillsViewModel(month: "January", sections: [incomeSection, investmentSection, expenseSection, creditCardSection])
    
    static var annualCalendar = AnnualCalendarViewModel(year: "2023")
    
    static var billCompleteId: String {
        return billComplete.id
    }
    
    static var billIncompleteId: String {
        return billIncomplete.id
    }
}
