//
//  WeeklyWorkerMock.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 13/09/23.
//

@testable import Financial_Control
import Foundation
import SharpnezCore

final class WeeklyWorkerMock: WeeklyWorkerProtocol {
    
    var isSuccess: Bool = true

    func save(weekBudgets: [Financial_Control.WeeklyBudgetViewModel]) throws {
        if !isSuccess {
            throw CoreError.customError("test error")
        }
    }
    
    func fetch() throws -> [Financial_Control.WeeklyBudgetViewModel] {
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
}
