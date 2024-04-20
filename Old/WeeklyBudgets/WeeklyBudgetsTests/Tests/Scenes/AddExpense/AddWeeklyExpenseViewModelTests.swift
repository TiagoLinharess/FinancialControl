//
//  AddWeeklyExpenseViewModelTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 21/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import SnapshotTesting
import SwiftUI
import XCTest

final class AddWeeklyExpenseViewModelTests: XCTestCase {

    var weeklyBudgetMock: WeeklyBudgetViewModel!
    var mock: WeeklyWorkerMock!
    var sut: AddWeeklyExpenseViewModel!
    
    override func setUpWithError() throws {
        weeklyBudgetMock = WeeklyBudgetViewModelMock.getOne()
        mock = .init()
        sut = .init(weekBudget: Binding(get: { return self.weeklyBudgetMock }, set: { _,_ in }), worker: mock)
    }
    
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }
    
    func test_payment_modes() throws {
        XCTAssertTrue(sut.paymentModes == ["select", "debit", "credit"])
    }
    
    func test_submit_success() throws {
        mock.isSuccess = true
        
        sut.title = "iphone"
        sut.paymentMode = "credit"
        sut.value = "$900.00"
        
        try sut.submit()
        
        XCTAssertTrue(sut.weekBudget.expenses.count == 1)
    }
    
    func test_submit_value_error() throws {
        mock.isSuccess = true
        
        sut.title = "iphone"
        sut.paymentMode = "credit"
        sut.value = "value error"
        
        do {
            try sut.submit()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Please, fill all fields correctly to continue.")
        }
    }
    
    func test_submit_value_worker_error() throws {
        mock.isSuccess = false
        
        sut.title = "iphone"
        sut.paymentMode = "credit"
        sut.value = "$900.00"
        
        do {
            try sut.submit()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
}
