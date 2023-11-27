//
//  WeeklyBudgetsRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 13/11/23.
//

import SwiftUI
import SharpnezCore

public protocol WeeklyBudgetsRepositoryProtocol {
    func create(weekBudgets: [WeeklyBudgetResponse]) throws
    func read() throws -> [WeeklyBudgetResponse]
    func update(weekBudget: WeeklyBudgetResponse) throws
    func delete(at offsets: IndexSet) throws -> Int
}

public final class WeeklyBudgetsRepository: WeeklyBudgetsRepositoryProtocol {
    
    let key: String
    
    public init(key: String? = nil) {
        self.key = key ?? Constants.UserDefaultsKeys.weekly
    }
    
    // MARK: Create
    
    public func create(weekBudgets: [WeeklyBudgetResponse]) throws {
        var allWeekBudgets = weekBudgets
        let currentWeekBudgets = try read()
        
        if compareBudgets(currentBudgets: currentWeekBudgets, newBudgets: weekBudgets) {
            throw CoreError.customError(Constants.WeeklyBudgetsRepository.existentWeek)
        }
        
        allWeekBudgets.append(contentsOf: currentWeekBudgets)
        
        let response: WeeklyBudgetListResponse = WeeklyBudgetListResponse(weekBudgets: allWeekBudgets)
        
        let data = try JSONEncoder().encode(response)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Read
    
    public func read() throws -> [WeeklyBudgetResponse] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let response = try JSONDecoder().decode(WeeklyBudgetListResponse.self, from: data)
        return response.weekBudgets
    }
    
    // MARK: Update
    
    public func update(weekBudget: WeeklyBudgetResponse) throws {
        var currentWeekBudgets = try read()
        
        guard let index = currentWeekBudgets.firstIndex(where: { currentWeekBudget in
            currentWeekBudget.id == weekBudget.id
        }) else {
            throw CoreError.customError(Constants.WeeklyBudgetsRepository.weekDoesNotExist)
        }
        
        currentWeekBudgets[index] = weekBudget
        let response: WeeklyBudgetListResponse = WeeklyBudgetListResponse(weekBudgets: currentWeekBudgets)
        
        let data = try JSONEncoder().encode(response)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Delete
    
    public func delete(at offsets: IndexSet) throws -> Int {
        var allWeekBudgets =  try read()
        allWeekBudgets.remove(atOffsets: offsets)
        
        let response: WeeklyBudgetListResponse = WeeklyBudgetListResponse(weekBudgets: allWeekBudgets)
        
        let data = try JSONEncoder().encode(response)
        UserDefaults.standard.set(data, forKey: key)
        return allWeekBudgets.count
    }
}

private extension WeeklyBudgetsRepository {
    
    // MARK: Private Methods
    
    func compareBudgets(currentBudgets: [WeeklyBudgetResponse], newBudgets: [WeeklyBudgetResponse]) -> Bool {
        currentBudgets.contains { currentBudget in
            newBudgets.contains { newBudget in
                return currentBudget.week == newBudget.week
            }
        }
    }
}
