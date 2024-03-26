//
//  WeeklyResponseMock.swift
//  ProviderTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import Provider
import Foundation

struct WeeklyResponseMock {
    
    static func getThree() -> [WeeklyBudgetResponse] {
        return [
            .init(
                id: "10/09/2023",
                week: "10/09/2023",
                originalBudget: 200,
                currentBudget: 200,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 200,
                expenses: []
            ),
            .init(
                id: "10/10/2023",
                week: "10/10/2023",
                originalBudget: 200,
                currentBudget: 54.27,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 160.20,
                expenses: []
            ),
            .init(
                id: "10/11/2023",
                week: "10/11/2023",
                originalBudget: 200,
                currentBudget: 101,
                creditCardWeekLimit: 200,
                creditCardRemainingLimit: 0,
                expenses: []
            )
        ]
    }
    
    static func getOne() -> WeeklyBudgetResponse {
        return .init(
            id: "10/09/2023",
            week: "10/09/2023",
            originalBudget: 200,
            currentBudget: 54.27,
            creditCardWeekLimit: 200,
            creditCardRemainingLimit: 160.20,
            expenses: []
        )
    }
}
