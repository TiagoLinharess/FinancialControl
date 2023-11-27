//
//  WeeklyBudgetListResponse.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

public struct WeeklyBudgetListResponse: Codable {
    let weekBudgets: [WeeklyBudgetResponse]
}
