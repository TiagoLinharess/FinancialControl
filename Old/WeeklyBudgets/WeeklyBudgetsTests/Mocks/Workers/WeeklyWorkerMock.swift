//
//  WeeklyWorkerMock.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 13/09/23.
//

@testable import WeeklyBudgets
import Foundation
import SharpnezCore

final class WeeklyWorkerMock: WeeklyWorkerProtocol {

    var isSuccess: Bool = true

    func save(weekBudgets: [WeeklyBudgets.WeeklyBudgetViewModel]) throws {
        if !isSuccess {
            throw CoreError.customError("test error")
        }
    }
    
    func fetch() throws -> [WeeklyBudgets.WeeklyBudgetViewModel] {
        if isSuccess {
            return WeeklyBudgetViewModelMock.getThree()
        }
        
        throw CoreError.customError("test error")
    }
    
    func delete(at offsets: IndexSet) throws -> Int {
        if isSuccess {
            return 0
        }
        
        throw CoreError.customError("test error")
    }
    
    func update(weekBudget: WeeklyBudgets.WeeklyBudgetViewModel) throws {
        if !isSuccess {
            throw CoreError.customError("test error")
        }
    }
}
