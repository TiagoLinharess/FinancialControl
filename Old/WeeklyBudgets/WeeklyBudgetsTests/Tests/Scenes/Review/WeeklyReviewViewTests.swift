//
//  WeeklyReviewViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 14/11/23.
//

import Core
@testable import WeeklyBudgets
import SharpnezCore
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyReviewViewTests: XCTestCase {
    
    var sut: WeeklyReviewView<WeeklyReviewViewModelMock>!
    var mock: WeeklyReviewViewModelMock!
    
    override func setUpWithError() throws {
        mock = .init(weeks: [WeeklyBudgetViewModelMock.getOne()])
        sut = .init(viewModel: mock)
    }
    
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_snapshot() throws {
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_alert_did_tapped() throws {
        sut.alertDidTapped()
        XCTAssertTrue(mock.presentAlert == false)
    }
    
    func test_submit_success() throws {
        mock.presentError = false
        sut.submit()
        
        XCTAssertTrue(mock.alertMessage == "Budgets added with success")
        XCTAssertTrue(mock.closeFlowAfterSubmit == true)
    }
    
    func test_submit_error() throws {
        mock.presentError = true
        sut.submit()
        
        XCTAssertTrue(mock.alertMessage == CoreError.parseError.message)
        XCTAssertTrue(mock.closeFlowAfterSubmit == false)
    }
}
