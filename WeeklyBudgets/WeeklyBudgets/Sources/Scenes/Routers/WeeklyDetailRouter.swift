//
//  WeeklyDetailRouter.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/10/23.
//

import SwiftUI

// MARK: Router

final class WeeklyDetailRouter: ObservableObject {
    
    // MARK: Properties
    
    @Published var path = NavigationPath()
    
    // MARK: Methods
    
    func push(_ destination: WeeklyDetailNavigationOption) {
        path.append(destination)
    }
    
    func pop(_ viewsCount: Int = 1) {
        path.removeLast(viewsCount)
    }
    
    @ViewBuilder func getDestination(from destination: WeeklyDetailNavigationOption) -> some View {
        switch destination {
        case let .addExpense(budget):
            AddWeeklyExpenseView(viewModel: AddWeeklyExpenseViewModel(weekBudget: budget), router: self)
        case let .editBudget(budget):
            EditBudgetView(viewModel: EditBudgetViewModel(budget: budget), router: self)
        }
    }
}

// MARK: Navigation Option

enum WeeklyDetailNavigationOption: Hashable {
    case addExpense(Binding<WeeklyBudgetViewModel>)
    case editBudget(Binding<WeeklyBudgetViewModel>)
    
    var intValue: Int {
        switch self {
        case .addExpense: return 0
        case .editBudget: return 1
        }
    }
    
    static func ==(lhs: WeeklyDetailNavigationOption, rhs: WeeklyDetailNavigationOption) -> Bool {
        return lhs.intValue == rhs.intValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(intValue)
    }
}
