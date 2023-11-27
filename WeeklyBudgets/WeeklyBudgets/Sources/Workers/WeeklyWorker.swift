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
        try repository.create(weekBudgets: viewModelBudgetListToResponseList(viewModels: weekBudgets))
    }
    
    // MARK: Fetch
    
    func fetch() throws -> [WeeklyBudgetViewModel] {
        let responseList = try repository.read()
        return responseBudgetListToViewModelList(responseList: responseList)
    }
    
    // MARK: Update
    
    func update(weekBudget: WeeklyBudgetViewModel) throws {
        try repository.update(weekBudget: viewModelBudgetToResponse(viewModel: weekBudget))
    }
    
    // MARK: Delete
    
    func delete(at offsets: IndexSet) throws -> Int {
        return try repository.delete(at: offsets)
    }
}

// MARK: Private Methods

private extension WeeklyWorker {
    
    // MARK: View Model To Response
    
    func viewModelBudgetListToResponseList(viewModels: [WeeklyBudgetViewModel]) -> [WeeklyBudgetResponse] {
        return viewModels.map { viewModel -> WeeklyBudgetResponse in
            return viewModelBudgetToResponse(viewModel: viewModel)
        }
    }
    
    func viewModelBudgetToResponse(viewModel: WeeklyBudgetViewModel) -> WeeklyBudgetResponse {
        return WeeklyBudgetResponse(
            id: viewModel.id,
            week: viewModel.week,
            originalBudget: viewModel.originalBudget,
            currentBudget: viewModel.currentBudget,
            creditCardWeekLimit: viewModel.creditCardWeekLimit,
            creditCardRemainingLimit: viewModel.creditCardRemainingLimit,
            expenses: viewModelExpenseListToResponseList(viewModels: viewModel.expenses)
        )
    }
    
    func viewModelExpenseListToResponseList(viewModels: [WeeklyExpenseViewModel]) -> [WeeklyExpenseResponse] {
        return viewModels.map { viewModel -> WeeklyExpenseResponse in
            return viewModelExpenseToResponse(viewModel: viewModel)
        }
    }
    
    func viewModelExpenseToResponse(viewModel: WeeklyExpenseViewModel) -> WeeklyExpenseResponse {
        return WeeklyExpenseResponse(
            id: viewModel.id,
            date: viewModel.date,
            title: viewModel.title,
            description: viewModel.description,
            paymentMode: .init(rawValue: viewModel.paymentMode.rawValue) ?? .debit,
            value: viewModel.value
        )
    }
}

private extension WeeklyWorker {
    
    // MARK: Response To View Model
    
    func responseBudgetListToViewModelList(responseList: [WeeklyBudgetResponse]) -> [WeeklyBudgetViewModel] {
        return responseList.map { response -> WeeklyBudgetViewModel in
            return WeeklyBudgetViewModel(from: response)
        }
    }
}
