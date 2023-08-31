//
//  WeeklyFinancesViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI
import SharpnezDesignSystem

// MARK: Protocol

protocol WeeklyFinancesHomeViewModelProtocol: ObservableObject {
    var viewStatus: ViewStatus { get }
    var budgets: [WeeklyBudgetViewModel] { get }
}

// MARK: View Model

final class WeeklyFinancesHomeViewModel: WeeklyFinancesHomeViewModelProtocol {
    
    // MARK: Properties
    
    @Published var viewStatus: ViewStatus = .none
    var budgets: [WeeklyBudgetViewModel] = []
    
}
