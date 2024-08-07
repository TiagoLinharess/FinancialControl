//
//  WeeklyBudgetViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Foundation
import Provider

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
        
        expenses.insert(expense, at: .zero)
    }
    
    func removeExpense(at offsets: IndexSet) {
        let expensesToRemove = offsets.map { expenses[$0] }[.zero]
        
        if expensesToRemove.paymentMode == .debit {
            currentBudget += expensesToRemove.value
        } else {
            creditCardRemainingLimit += expensesToRemove.value
        }
        
        expenses.remove(atOffsets: offsets)
    }
    
    func getResponse() -> WeeklyBudgetResponse {
        return WeeklyBudgetResponse(
            id: id,
            week: week,
            originalBudget: originalBudget,
            currentBudget: currentBudget,
            creditCardWeekLimit: creditCardWeekLimit,
            creditCardRemainingLimit: creditCardRemainingLimit,
            expenses: expenses.map { viewModel -> WeeklyExpenseResponse in
                return viewModel.getResponse()
            }
        )
    }
}
