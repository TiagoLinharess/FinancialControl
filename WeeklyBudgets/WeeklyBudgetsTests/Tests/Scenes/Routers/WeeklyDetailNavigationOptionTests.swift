//
//  WeeklyDetailNavigationOptionTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

@testable import WeeklyBudgets
import SwiftUI
import XCTest

final class WeeklyDetailNavigationOptionTests: XCTestCase {

    func test_equal() throws {
        let sut0 = WeeklyDetailNavigationOption.addExpense(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in }))
        let sut1 = WeeklyDetailNavigationOption.editBudget(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in }))
        
        XCTAssertTrue(sut0 != sut1)
    }
}
