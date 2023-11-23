//
//  WeeklyWorkerTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import XCTest

final class WeeklyWorkerTests: XCTestCase {
    
    var sut: WeeklyWorker!
    var mock: WeeklyBudgetsRepositoryMock!

    override func setUpWithError() throws {
        mock = .init()
        sut = .init(repository: mock)
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_save_success() throws {
        mock.isError = false
        try sut.save(weekBudgets: [WeeklyBudgetViewModelMock.getOne(addExpense: true)])
    }
    
    func test_save_error() throws {
        do {
            mock.isError = true
            try sut.save(weekBudgets: [WeeklyBudgetViewModelMock.getOne(addExpense: true)])
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
    
    func test_fecth_success() throws {
        mock.isError = false
        let budgets = try sut.fetch()
        XCTAssertTrue(budgets.count == 1)
    }
    
    func test_fetch_error() throws {
        do {
            mock.isError = true
            let _ = try sut.fetch()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
    
    func test_update_success() throws {
        mock.isError = false
        try sut.update(weekBudget: WeeklyBudgetViewModelMock.getOne(addExpense: true))
    }
    
    func test_update_error() throws {
        do {
            mock.isError = true
            try sut.update(weekBudget: WeeklyBudgetViewModelMock.getOne(addExpense: true))
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
    
    func test_delete_success() throws {
        mock.isError = false
        let count = try sut.delete(at: .init())
        XCTAssertTrue(count == 0)
    }
    
    func test_delete_error() throws {
        do {
            mock.isError = true
            let _ = try sut.delete(at: .init())
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
}
