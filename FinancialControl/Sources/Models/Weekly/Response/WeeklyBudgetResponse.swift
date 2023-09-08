//
//  WeeklyBudgetResponse.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

class WeeklyBudgetResponse: Identifiable, Codable {
    
    // MARK: Properties
    
    let id: String
    let week: String
    let originalBudget: Double
    let currentBudget: Double
    let creditCardWeekLimit: Double
    let creditCardRemainingLimit: Double
    var expenses: [WeeklyExpenseResponse] = []
    
    // MARK: Init From ViewModel
    
    init(from viewModel: WeeklyBudgetViewModel) {
        self.id = viewModel.id
        self.week = viewModel.week
        self.originalBudget = viewModel.originalBudget
        self.currentBudget = viewModel.currentBudget
        self.creditCardWeekLimit = viewModel.creditCardWeekLimit
        self.creditCardRemainingLimit = viewModel.creditCardRemainingLimit
        self.expenses = viewModel.expenses.map { viewModel -> WeeklyExpenseResponse in
            return .init(from: viewModel)
        }
    }
}
