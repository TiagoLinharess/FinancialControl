//
//  BillViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
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
    
    func getIncomesExtractViewModel() -> ExtractViewModel {
        return ExtractViewModel(
            title: CoreConstants.Commons.incomesKey,
            rows: [
                .init(title: CoreConstants.Commons.salaryKey, value: income?.salary),
                .init(title: CoreConstants.Commons.bonusKey, value: income?.bonus),
                .init(title: CoreConstants.Commons.extraKey, value: income?.extra),
                .init(title: CoreConstants.Commons.otherKey, value: income?.other),
                .init(title: CoreConstants.Commons.total, value: income?.total),
            ]
        )
    }
    
    func getInvestmentsExtractViewModel() -> ExtractViewModel {
        return ExtractViewModel(
            title: CoreConstants.Commons.investmentsKey,
            rows: [
                .init(title: CoreConstants.Commons.sharesKey, value: investment?.shares),
                .init(title: CoreConstants.Commons.privatePensionKey, value: investment?.privatePension),
                .init(title: CoreConstants.Commons.fixedIncomeKey, value: investment?.fixedIncome),
                .init(title: CoreConstants.Commons.otherKey, value: investment?.other),
                .init(title: CoreConstants.Commons.total, value: investment?.total),
            ]
        )
    }
    
    func getExpensesExtractViewModel() -> ExtractViewModel {
        return ExtractViewModel(
            title: CoreConstants.Commons.expensesKey,
            rows: [
                .init(title: CoreConstants.Commons.housingKey, value: expense?.housing),
                .init(title: CoreConstants.Commons.transportKey, value: expense?.transport),
                .init(title: CoreConstants.Commons.feedKey, value: expense?.feed),
                .init(title: CoreConstants.Commons.healthKey, value: expense?.health),
                .init(title: CoreConstants.Commons.educationKey, value: expense?.education),
                .init(title: CoreConstants.Commons.taxesKey, value: expense?.taxes),
                .init(title: CoreConstants.Commons.laisureKey, value: expense?.laisure),
                .init(title: CoreConstants.Commons.clothingKey, value: expense?.clothing),
                .init(title: CoreConstants.Commons.creditCardKey, value: expense?.creditCard),
                .init(title: CoreConstants.Commons.otherKey, value: expense?.other),
                .init(title: CoreConstants.Commons.total, value: expense?.total),
            ]
        )
    }
}
