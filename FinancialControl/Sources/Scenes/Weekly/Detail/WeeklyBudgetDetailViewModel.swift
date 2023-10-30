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
}

// MARK: View Model

final class WeeklyBudgetDetailViewModel: WeeklyBudgetDetailViewModelProtocol {

    // MARK: Properties
    
    @Binding var weekBudget: WeeklyBudgetViewModel
    
    init(weekBudget: Binding<WeeklyBudgetViewModel>) {
        self._weekBudget = weekBudget
    }
}
