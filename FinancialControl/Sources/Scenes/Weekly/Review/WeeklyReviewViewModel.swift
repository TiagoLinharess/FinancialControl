//
//  WeeklyReviewViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 02/09/23.
//

import Combine

protocol WeeklyReviewViewModelProtocol: ObservableObject {
    var presentAlert: Bool { get set }
    var weeks: [WeeklyBudgetViewModel] { get }
    func submit()
}

final class WeeklyReviewViewModel: WeeklyReviewViewModelProtocol {
    
    @Published var presentAlert: Bool = false
    let weeks: [WeeklyBudgetViewModel]

    init(weeks: [WeeklyBudgetViewModel]) {
        self.weeks = weeks
    }
    
    func submit() {
        presentAlert = true
    }
}
