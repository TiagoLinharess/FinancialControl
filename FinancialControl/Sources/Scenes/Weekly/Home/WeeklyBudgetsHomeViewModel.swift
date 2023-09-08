//
//  WeeklyBudgetssViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI
import SharpnezDesignSystem

// MARK: View Status

enum WeeklyBudgetsHomeViewStatus {
    case success, error(String), empty
}

// MARK: Protocol

protocol WeeklyBudgetsHomeViewModelProtocol: ObservableObject {
    var viewStatus: WeeklyBudgetsHomeViewStatus { get }
    var budgets: [WeeklyBudgetViewModel] { get }
    var addBudgetFlowPresented: Bool { get set }
    func fetchBudgets()
    func didTapAddBudget()
    func delete(at offsets: IndexSet)
}

// MARK: View Model

final class WeeklyBudgetsHomeViewModel: WeeklyBudgetsHomeViewModelProtocol {
    
    // MARK: Properties
    
    @Published var viewStatus: WeeklyBudgetsHomeViewStatus = .empty
    @Published var addBudgetFlowPresented: Bool = false
    var budgets: [WeeklyBudgetViewModel] = []
    
    private let worker: WeeklyWorkerProtocol
    
    // MARK: Init
    
    init(worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self.worker = worker
    }
    
    // MARK: Methods
    
    func didTapAddBudget() {
        addBudgetFlowPresented.toggle()
    }
    
    func fetchBudgets() {
        viewStatus = .empty
        do {
            budgets = try worker.fetch()
            viewStatus = budgets.isEmpty ? .empty : .success
        } catch {
            viewStatus = .error(error.localizedDescription)
        }
    }
    
    func delete(at offsets: IndexSet) {
        do {
            let count = try worker.delete(at: offsets)
            if count == 0 {
                viewStatus = .empty
            }
        } catch {
            viewStatus = .error(error.localizedDescription)
        }
    }
}
