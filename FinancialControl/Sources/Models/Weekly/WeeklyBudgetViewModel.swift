//
//  WeeklyBudgetViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Foundation

class WeeklyBudgetViewModel: Identifiable, Codable {
    
    let id: String
    let month: String
    let week: String
    let originalBudget: Double
    let currentBudget: Double
    let creditCardWeekLimit: Double
    let creditCardRemainingLimit: Double
    var expenses: [WeeklyExpenseViewModel] = []
    
    init(
        id: String,
        month: String,
        week: String,
        originalBudget: Double,
        currentBudget: Double,
        creditCardWeekLimit: Double,
        creditCardRemainingLimit: Double
    ) {
        self.id = id
        self.month = month
        self.week = week
        self.originalBudget = originalBudget
        self.currentBudget = currentBudget
        self.creditCardWeekLimit = creditCardWeekLimit
        self.creditCardRemainingLimit = creditCardRemainingLimit
    }
}
