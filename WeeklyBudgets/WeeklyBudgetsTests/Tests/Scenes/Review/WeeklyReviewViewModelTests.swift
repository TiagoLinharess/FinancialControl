//
//  WeeklyReviewViewModelTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import XCTest

final class WeeklyReviewViewModelTests: XCTestCase {
    
    var sut: WeeklyReviewViewModel!
    var mock: WeeklyWorkerMock!
    
    override func setUpWithError() throws {
        mock = .init()
        sut = .init(weeks: [WeeklyBudgetViewModelMock.getOne()], worker: mock)
    }
    
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_submit_success() throws {
        mock.isSuccess = true
        
        try sut.submit()
        XCTAssertTrue(sut.closeFlowAfterSubmit)
    }
    
    func test_submit_error() throws {
        mock.isSuccess = false
        
        do {
            try sut.submit()
        } catch {
            XCTAssertFalse(sut.closeFlowAfterSubmit)
            XCTAssertTrue((error as? CoreError)?.message == "test error")
        }
    }
}
