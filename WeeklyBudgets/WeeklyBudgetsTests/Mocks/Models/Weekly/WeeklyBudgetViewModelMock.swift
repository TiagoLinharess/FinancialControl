//
//  WeeklyBudgetViewModelMock.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 08/09/23.
//

@testable import WeeklyBudgets
import Foundation

struct WeeklyBudgetViewModelMock {
    
    static func getThree() -> [WeeklyBudgetViewModel] {
        return [
            .init(
                id: "10/09/2023",
                week: "10/09/2023",
                originalBudget: 200,
                currentBudget: 54.27,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 160.20
            ),
            .init(
                id: "11/09/2023",
                week: "11/09/2023",
                originalBudget: 400,
                currentBudget: 398.00,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 80.20
            ),
            .init(
                id: "12/09/2023",
                week: "12/09/2023",
                originalBudget: 500,
                currentBudget: 200,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 0.00
            )
        ]
    }
    
    static func getOne(addExpense: Bool = false) -> WeeklyBudgetViewModel {
        let mock = WeeklyBudgetViewModel(
            id: "10/09/2023",
            week: "10/09/2023",
            originalBudget: 200,
            currentBudget: 54.27,
            creditCardWeekLimit: 200,
            creditCardRemainingLimit: 160.20
        )
        
        if addExpense {
            mock.addExpense(expense: .init(title: "iphone", paymentMode: .debit, value: 1000.99))
        }
        
        return mock
    }
}
