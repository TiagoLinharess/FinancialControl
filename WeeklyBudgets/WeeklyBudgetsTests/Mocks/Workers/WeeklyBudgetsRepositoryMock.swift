//
//  WeeklyBudgetsRepositoryMock.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

import Provider
import Foundation
import SharpnezCore

final class WeeklyBudgetsRepositoryMock: WeeklyBudgetsRepositoryProtocol {
    
    var isError: Bool = false
    
    func create(weekBudgets: [Provider.WeeklyBudgetResponse]) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func read() throws -> [Provider.WeeklyBudgetResponse] {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return [.init(id: UUID().uuidString, week: "12/12/2023", originalBudget: 200, currentBudget: 190, creditCardWeekLimit: 300, creditCardRemainingLimit: 100, expenses: [.init(id: UUID().uuidString, date: .now, title: "iphone", paymentMode: .credit, value: 200)])]
    }
    
    func update(weekBudget: Provider.WeeklyBudgetResponse) throws {
        if isError {
            throw CoreError.customError("test error")
        }
    }
    
    func delete(at offsets: IndexSet) throws -> Int {
        if isError {
            throw CoreError.customError("test error")
        }
        
        return 0
    }
}
