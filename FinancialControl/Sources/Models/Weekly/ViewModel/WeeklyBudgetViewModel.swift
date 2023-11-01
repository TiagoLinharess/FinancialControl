//
//  WeeklyBudgetViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Foundation

class WeeklyBudgetViewModel: Identifiable {
    
    // MARK: Properties
    
    let id: String
    let week: String
    var originalBudget: Double
    var currentBudget: Double
    var creditCardWeekLimit: Double
    var creditCardRemainingLimit: Double
    var expenses: [WeeklyExpenseViewModel] = []
    
    // MARK: Init
    
    init(
        id: String,
        week: String,
        originalBudget: Double,
        currentBudget: Double,
        creditCardWeekLimit: Double,
        creditCardRemainingLimit: Double
    ) {
        self.id = id
        self.week = week
        self.originalBudget = originalBudget
        self.currentBudget = currentBudget
        self.creditCardWeekLimit = creditCardWeekLimit
        self.creditCardRemainingLimit = creditCardRemainingLimit
    }
    
    // MARK: Add Week Form Init
    
    init(
        week: String,
        originalBudget: Double,
        creditCardWeekLimit: Double
    ) {
        self.id = UUID().uuidString
        self.week = week
        self.originalBudget = originalBudget
        self.currentBudget = originalBudget
        self.creditCardWeekLimit = creditCardWeekLimit
        self.creditCardRemainingLimit = creditCardWeekLimit
    }
    
    // MARK: Init From Response
    
    init(from response: WeeklyBudgetResponse) {
        self.id = response.id
        self.week = response.week
        self.originalBudget = response.originalBudget
        self.currentBudget = response.currentBudget
        self.creditCardWeekLimit = response.creditCardWeekLimit
        self.creditCardRemainingLimit = response.creditCardRemainingLimit
        self.expenses = response.expenses.map { response -> WeeklyExpenseViewModel in
            return .init(from: response)
        }
    }
    
    // MARK: Methods
    
    func addExpense(expense: WeeklyExpenseViewModel) {
        if expense.paymentMode == .debit {
            currentBudget -= expense.value
        } else {
            creditCardRemainingLimit -= expense.value
        }
        
        expenses.append(expense)
    }
}
