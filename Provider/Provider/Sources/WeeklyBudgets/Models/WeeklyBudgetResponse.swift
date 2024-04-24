//
//  WeeklyBudgetResponse.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

public struct WeeklyBudgetResponse: Identifiable, Codable {
    
    // MARK: Properties
    
    public let id: String
    public let week: String
    public let originalBudget: Double
    public let currentBudget: Double
    public let creditCardWeekLimit: Double
    public let creditCardRemainingLimit: Double
    public var expenses: [WeeklyExpenseResponse] = []
    
    // MARK: Init
    
    public init(id: String, week: String, originalBudget: Double, currentBudget: Double, creditCardWeekLimit: Double, creditCardRemainingLimit: Double, expenses: [WeeklyExpenseResponse]) {
        self.id = id
        self.week = week
        self.originalBudget = originalBudget
        self.currentBudget = currentBudget
        self.creditCardWeekLimit = creditCardWeekLimit
        self.creditCardRemainingLimit = creditCardRemainingLimit
        self.expenses = expenses
    }
}
