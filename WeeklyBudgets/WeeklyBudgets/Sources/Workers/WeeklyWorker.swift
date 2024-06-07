//
//  WeeklyWorker.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation
import Provider
import SharpnezCore

// MARK: Protocol

protocol WeeklyWorkerProtocol {
    func save(weekBudgets: [WeeklyBudgetViewModel]) throws
    func fetch() throws -> [WeeklyBudgetViewModel]
    func update(weekBudget: WeeklyBudgetViewModel) throws
    func delete(at offsets: IndexSet) throws -> Int
}

// MARK: Worker

final class WeeklyWorker: WeeklyWorkerProtocol {
    
    private let repository: WeeklyBudgetsRepositoryProtocol
    
    init(repository: WeeklyBudgetsRepositoryProtocol = WeeklyBudgetsRepository()) {
        self.repository = repository
    }
    
    // MARK: Save
    
    func save(weekBudgets: [WeeklyBudgetViewModel]) throws {
        try repository.create(
            weekBudgets: weekBudgets.map { viewModel -> WeeklyBudgetResponse in
                return viewModel.getResponse()
            }
        )
    }
    
    // MARK: Fetch
    
    func fetch() throws -> [WeeklyBudgetViewModel] {
        let responseList = try repository.read()
        return responseList.map { response -> WeeklyBudgetViewModel in
            return WeeklyBudgetViewModel(from: response)
        }
    }
    
    // MARK: Update
    
    func update(weekBudget: WeeklyBudgetViewModel) throws {
        try repository.update(weekBudget: weekBudget.getResponse())
    }
    
    // MARK: Delete
    
    func delete(at offsets: IndexSet) throws -> Int {
        return try repository.delete(at: offsets)
    }
}
