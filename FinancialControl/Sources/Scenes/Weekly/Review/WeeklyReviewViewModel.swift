//
//  WeeklyReviewViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 02/09/23.
//

import Combine

// MARK: Protocol

protocol WeeklyReviewViewModelProtocol: ObservableObject {
    var presentAlert: Bool { get set }
    var weeks: [WeeklyBudgetViewModel] { get }
    func submit()
}

// MARK: View Model

final class WeeklyReviewViewModel: WeeklyReviewViewModelProtocol {
    
    // MARK: Properties
    
    @Published var presentAlert: Bool = false
    let weeks: [WeeklyBudgetViewModel]
    
    private let worker: WeeklyWorkerProtocol
    
    // MARK: Init

    init(weeks: [WeeklyBudgetViewModel], worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self.weeks = weeks
        self.worker = worker
    }
    
    // MARK: Methods
    
    func submit() {
        do {
            try worker.save(weekBudgets: weeks)
            presentAlert = true
        } catch {
            print(error)
        }
    }
}
