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
    var alertMessage: String { get set }
    var closeFlowAfterSubmit: Bool { get set }
    var weeks: [WeeklyBudgetViewModel] { get set }
    func submit() throws
}

// MARK: View Model

final class WeeklyReviewViewModel: WeeklyReviewViewModelProtocol {
    
    // MARK: Properties
    
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = String()
    @Published var closeFlowAfterSubmit: Bool = false
    @Published var weeks: [WeeklyBudgetViewModel]
    
    private let worker: WeeklyWorkerProtocol
    
    // MARK: Init

    init(weeks: [WeeklyBudgetViewModel], worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self.weeks = weeks
        self.worker = worker
    }
    
    // MARK: Methods
    
    func submit() throws {
        do {
            try worker.save(weekBudgets: weeks)
            closeFlowAfterSubmit = true
        } catch {
            closeFlowAfterSubmit = false
            throw error
        }
    }
}
