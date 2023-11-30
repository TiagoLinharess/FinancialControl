//
//  BillViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation

struct MonthlyBillViewModel {
    
    // MARK: Properties
    
    let month: String
    var income: IncomeViewModel?
    var investment: InvestmentViewModel?
    var expense: ExpenseViewModel?
    
    var balance: Double {
        guard let income else { return .zero }
        guard let investment, let expense else { return income.total }
        
        return income.total - (investment.total + expense.total)
    }
    
    // MARK: Init
    
    init(
        month: String,
        income: IncomeViewModel? = nil,
        investment: InvestmentViewModel? = nil,
        expense: ExpenseViewModel? = nil
    ) {
        self.month = month
        self.income = income
        self.investment = investment
        self.expense = expense
    }
    
    // MARK: Methods
    
    func percentageOfRevenue(value: Double) -> Double {
        guard let income else { return 100 }
        return (value / income.total) * 100
    }
}
