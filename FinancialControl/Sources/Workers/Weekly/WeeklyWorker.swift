//
//  WeeklyWorker.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

// MARK: Protocol

protocol WeeklyWorkerProtocol {
    func save(weekBudgets: [WeeklyBudgetViewModel]) throws
    func fetch() throws -> [WeeklyBudgetViewModel]
    func delete(at offsets: IndexSet) throws -> Int
}

// MARK: Worker

final class WeeklyWorker: WeeklyWorkerProtocol {
    
    // MARK: Save
    
    func save(weekBudgets: [WeeklyBudgetViewModel]) throws {
        var allWeekBudgets = weekBudgets
        allWeekBudgets.append(contentsOf: try fetch())
        
        let response: WeeklyBudgetListResponse = .init(
            weekBudgets: allWeekBudgets.map { viewModel -> WeeklyBudgetResponse in
                return .init(from: viewModel)
            }
        )
        
        let data = try JSONEncoder().encode(response)
        UserDefaults.standard.set(data, forKey: getEnvironmentKey())
    }
    
    // MARK: Fetch
    
    func fetch() throws -> [WeeklyBudgetViewModel] {
        guard let data = UserDefaults.standard.data(forKey: getEnvironmentKey()) else { return [] }
        
        let response = try JSONDecoder().decode(WeeklyBudgetListResponse.self, from: data)
        let weeks = response.weekBudgets.map { response -> WeeklyBudgetViewModel in
            return .init(from: response)
        }
        
        return weeks
    }
    
    // MARK: Delete
    
    func delete(at offsets: IndexSet) throws -> Int {
        var allWeekBudgets =  try fetch()
        allWeekBudgets.remove(atOffsets: offsets)
        
        let response: WeeklyBudgetListResponse = .init(
            weekBudgets: allWeekBudgets.map { viewModel -> WeeklyBudgetResponse in
                return .init(from: viewModel)
            }
        )
        
        let data = try JSONEncoder().encode(response)
        UserDefaults.standard.set(data, forKey: getEnvironmentKey())
        return allWeekBudgets.count
    }
}

private extension WeeklyWorker {
    
    // MARK: Private Methods
    
    func getEnvironmentKey() -> String {
        if let bundleID = Bundle.main.bundleIdentifier, bundleID == Constants.Worker.developmentBundleID {
            return Constants.Worker.weeklyDevelopKey
        }
        
        return Constants.Worker.weeklyProductionKey
    }
}
