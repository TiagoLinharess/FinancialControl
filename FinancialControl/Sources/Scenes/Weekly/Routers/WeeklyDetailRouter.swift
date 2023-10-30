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
        case .addExpense:
            Text("addExpense")
        case .editBudget:
            Text("editBudget")
        case .review:
            Text("review")
        }
    }
}

// MARK: Navigation Option

enum WeeklyDetailNavigationOption: Hashable {
    case addExpense
    case editBudget
    case review
    
    var intValue: Int {
        switch self {
        case .addExpense: return 0
        case .editBudget: return 1
        case .review: return 2
        }
    }
    
    static func ==(lhs: WeeklyDetailNavigationOption, rhs: WeeklyDetailNavigationOption) -> Bool {
        return lhs.intValue == rhs.intValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(intValue)
    }
}
