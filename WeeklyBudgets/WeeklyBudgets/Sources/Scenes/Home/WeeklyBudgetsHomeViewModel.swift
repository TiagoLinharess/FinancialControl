//
//  WeeklyBudgetssViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI
import SharpnezCore
import SharpnezDesignSystem

// MARK: View Status

enum WeeklyBudgetsHomeViewStatus: Equatable {
    case success, error(String), empty
}

// MARK: Protocol

protocol WeeklyBudgetsHomeViewModelProtocol: ObservableObject {
    var viewStatus: WeeklyBudgetsHomeViewStatus { get }
    var budgets: [WeeklyBudgetViewModel] { get set }
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
    @Published var budgets: [WeeklyBudgetViewModel] = []
    
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
        } catch let error as CoreError {
            viewStatus = .error(error.message)
            budgets = []
        } catch {
            viewStatus = .error(Constants.Commons.defaultErrorMessage)
            budgets = []
        }
    }
    
    func delete(at offsets: IndexSet) {
        do {
            let count = try worker.delete(at: offsets)
            budgets.remove(atOffsets: offsets)
            if count == .zero {
                viewStatus = .empty
            }
        } catch let error as CoreError {
            viewStatus = .error(error.message)
        } catch {
            viewStatus = .error(Constants.Commons.defaultErrorMessage)
        }
    }
}
