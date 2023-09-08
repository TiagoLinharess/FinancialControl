//
//  WeeklyRouter.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 04/09/23.
//

import SwiftUI

// MARK: Router

final class WeeklyRouter: ObservableObject {
    
    // MARK: Properties
    
    @Published var path = NavigationPath()
    
    // MARK: Methods
    
    func push(_ destination: WeeklyNavigationOption) {
        path.append(destination)
    }
    
    func pop(_ viewsCount: Int = 1) {
        path.removeLast(viewsCount)
    }
    
    @ViewBuilder func routeTo(_ destination: WeeklyNavigationOption) -> some View {
        switch destination {
        case .singleWeekForm:
            SingleWeekFormView(viewModel: SingleWeekFormViewModel(), router: self)
        case .fullMonthForm:
            FullMonthFormView()
        case let .review(weeks):
            WeeklyReviewView(viewModel: WeeklyReviewViewModel(weeks: weeks))
        }
    }
}

// MARK: Navigation Option

enum WeeklyNavigationOption: Hashable {
    case singleWeekForm
    case fullMonthForm
    case review([WeeklyBudgetViewModel])
    
    var intValue: Int {
        switch self {
        case .singleWeekForm: return 0
        case .fullMonthForm: return 1
        case .review: return 2
        }
    }
    
    static func ==(lhs: WeeklyNavigationOption, rhs: WeeklyNavigationOption) -> Bool {
        return lhs.intValue == rhs.intValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(intValue)
    }
}
