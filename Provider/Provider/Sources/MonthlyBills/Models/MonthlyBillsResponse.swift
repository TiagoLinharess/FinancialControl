//
//  MonthlyBillsResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct MonthlyBillsResponse: Codable {
    
    // MARK: Properties
    
    public let id: String
    public let month: String
    public let income: IncomeResponse?
    public let investment: InvestmentResponse?
    public let expense: ExpenseResponse?
    
    // MARK: Init
    
    public init(
        id: String,
        month: String,
        income: IncomeResponse?,
        investment: InvestmentResponse?,
        expense: ExpenseResponse?
    ) {
        self.id = id
        self.month = month
        self.income = income
        self.investment = investment
        self.expense = expense
    }
}
