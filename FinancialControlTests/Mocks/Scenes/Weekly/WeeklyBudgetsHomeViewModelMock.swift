//
//  WeeklyBudgetsHomeViewModelMock.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 08/09/23.
//

@testable import Financial_Control
import Foundation

final class WeeklyBudgetsHomeViewModelMock: WeeklyBudgetsHomeViewModelProtocol {
    
    var viewStatus: WeeklyBudgetsHomeViewStatus
    
    var budgets: [WeeklyBudgetViewModel]
    
    var addBudgetFlowPresented: Bool
    
    init(viewStatus: WeeklyBudgetsHomeViewStatus, budgets: [WeeklyBudgetViewModel], addBudgetFlowPresented: Bool) {
        self.viewStatus = viewStatus
        self.budgets = budgets
        self.addBudgetFlowPresented = addBudgetFlowPresented
    }
    
    func fetchBudgets() {
        // not implemented
    }
    
    func didTapAddBudget() {
        // not implemented
    }
    
    func delete(at offsets: IndexSet) {
        // not implemented
    }
}
