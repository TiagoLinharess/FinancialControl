//
//  WeeklyReviewViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 02/09/23.
//

import Combine

protocol WeeklyReviewViewModelProtocol: ObservableObject {
    var weeks: [WeeklyBudgetViewModel] { get }
}

final class WeeklyReviewViewModel: WeeklyReviewViewModelProtocol {
    
    let weeks: [WeeklyBudgetViewModel]

    init(weeks: [WeeklyBudgetViewModel]) {
        self.weeks = weeks
    }
}
