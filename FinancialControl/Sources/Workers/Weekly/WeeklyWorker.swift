//
//  WeeklyWorker.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation
import SharpnezCore

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
        do {
            var allWeekBudgets = weekBudgets
            allWeekBudgets.append(contentsOf: try fetch())
            
            let response: WeeklyBudgetListResponse = .init(
                weekBudgets: allWeekBudgets.map { viewModel -> WeeklyBudgetResponse in
                    return .init(from: viewModel)
                }
            )
            
            let data = try JSONEncoder().encode(response)
            UserDefaults.standard.set(data, forKey: getEnvironmentKey())
        } catch {
            throw CoreError.parseError
        }
    }
    
    // MARK: Fetch
    
    func fetch() throws -> [WeeklyBudgetViewModel] {
        guard let data = UserDefaults.standard.data(forKey: getEnvironmentKey()) else { return [] }
        
        do {
            let response = try JSONDecoder().decode(WeeklyBudgetListResponse.self, from: data)
            let weeks = response.weekBudgets.map { response -> WeeklyBudgetViewModel in
                return .init(from: response)
            }
            
            return weeks
        } catch {
            throw CoreError.parseError
        }
    }
    
    // MARK: Delete
    
    func delete(at offsets: IndexSet) throws -> Int {
        do {
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
        } catch {
            throw CoreError.parseError
        }
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
