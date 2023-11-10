//
//  WeeklyBudgetsHomeViewModelTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 08/09/23.
//

@testable import WeeklyBudgets
import XCTest

final class WeeklyBudgetsHomeViewModelTests: XCTestCase {
    
    var mock: WeeklyWorkerMock!
    var sut: WeeklyBudgetsHomeViewModel!

    override func setUpWithError() throws {
        mock = .init()
        sut = WeeklyBudgetsHomeViewModel(worker: mock)
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_did_tap_add_budget() throws {
        sut.didTapAddBudget()
        XCTAssertTrue(sut.addBudgetFlowPresented)
    }
    
    func test_fetch_budgets_success() throws {
        mock.isSuccess = true
        sut.fetchBudgets()
        XCTAssertTrue(sut.viewStatus == .success)
        XCTAssertFalse(sut.budgets.isEmpty)
    }
    
    func test_fetch_budgets_error() throws {
        mock.isSuccess = false
        sut.fetchBudgets()
        XCTAssertTrue(sut.viewStatus == .error("test error"))
        XCTAssertTrue(sut.budgets.isEmpty)
    }
    
    func test_delete_budgets_success() throws {
        mock.isSuccess = true
        sut.budgets = [WeeklyBudgetViewModelMock.getOne()]
        sut.delete(at: .init(integer: 0))
        XCTAssertTrue(sut.viewStatus == .empty)
        XCTAssertTrue(sut.budgets.isEmpty)
    }
    
    func test_delete_budgets_error() throws {
        mock.isSuccess = false
        sut.delete(at: .init(integer: 0))
        XCTAssertTrue(sut.viewStatus == .error("test error"))
    }
}
