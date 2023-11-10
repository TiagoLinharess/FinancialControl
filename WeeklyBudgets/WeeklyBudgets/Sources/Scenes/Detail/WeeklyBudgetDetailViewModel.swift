//
//  WeeklyBudgetDetailViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/10/23.
//

import SwiftUI

// MARK: Protocol

protocol WeeklyBudgetDetailViewModelProtocol: ObservableObject {
    var weekBudget: WeeklyBudgetViewModel { get set }
    func deleteExpense(at offsets: IndexSet) throws
}

// MARK: View Model

final class WeeklyBudgetDetailViewModel: WeeklyBudgetDetailViewModelProtocol {

    // MARK: Properties
    
    @Published var weekBudget: WeeklyBudgetViewModel
    
    private let worker: WeeklyWorkerProtocol
    
    init(weekBudget: WeeklyBudgetViewModel, worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self.weekBudget = weekBudget
        self.worker = worker
    }
    
    // MARK: Methods
    
    func deleteExpense(at offsets: IndexSet) throws {
        let newWeekBudget = weekBudget
        newWeekBudget.removeExpense(at: offsets)
        
        do {
            try worker.update(weekBudget: newWeekBudget)
            weekBudget = newWeekBudget
        } catch {
            throw error
        }
    }
}
