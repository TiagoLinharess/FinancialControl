//
//  WeeklyBudgetDetailViewModelTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 17/11/23.
//

@testable import WeeklyBudgets
import XCTest

final class WeeklyBudgetDetailViewModelTests: XCTestCase {
    
    var mock: WeeklyWorkerMock!
    var sut: WeeklyBudgetDetailViewModel!

    override func setUpWithError() throws {
        mock = .init()
        sut = WeeklyBudgetDetailViewModel(weekBudget: WeeklyBudgetViewModelMock.getOne(addExpense: true), worker: mock)
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_did_delete() throws {
        try sut.deleteExpense(at: .init(integer: 0))
        XCTAssert(sut.weekBudget.expenses.count == .zero)
    }
}
