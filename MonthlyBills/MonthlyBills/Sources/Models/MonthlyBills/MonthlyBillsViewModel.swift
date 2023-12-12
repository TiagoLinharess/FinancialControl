//
//  BillViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import Provider

struct MonthlyBillsViewModel {
    
    // MARK: Properties
    
    let id: String
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
        self.id = UUID().uuidString
        self.month = month
        self.income = income
        self.investment = investment
        self.expense = expense
    }
    
    // MARK: Init from response
    
    init(from response: MonthlyBillsResponse) {
        self.id = response.id
        self.month = response.month
        self.income = IncomeViewModel(from: response.income)
        self.investment = InvestmentViewModel(from: response.investment)
        self.expense = ExpenseViewModel(from: response.expense)
    }
    
    // MARK: Methods
    
    func percentageOfRevenue(value: Double) -> Double {
        guard let income else { return 100 }
        return (value / income.total) * 100
    }
    
    func getResponse() -> MonthlyBillsResponse {
        return .init(
            id: id,
            month: month,
            income: income?.getResponse(),
            investment: investment?.getResponse(),
            expense: expense?.getResponse()
        )
    }
}
