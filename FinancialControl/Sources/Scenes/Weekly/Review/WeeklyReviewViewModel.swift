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
    
    private let worker: WeeklyWorkerProtocol

    init(weeks: [WeeklyBudgetViewModel], worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self.weeks = weeks
        self.worker = worker
    }
    
    func submit() {
        do {
            try worker.save(weekBudgets: weeks)
            presentAlert = true
        } catch {
            print(error)
        }
    }
}
