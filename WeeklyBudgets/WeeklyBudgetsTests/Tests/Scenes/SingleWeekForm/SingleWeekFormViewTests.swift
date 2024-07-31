//
//  SingleWeekFormViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

import Core
@testable import WeeklyBudgets
import SharpnezCore
import SnapshotTesting
import SwiftUI
import XCTest

final class SingleWeekFormViewTests: XCTestCase {
    
    var sut: AddBudgetView<SingleWeekFormViewModelMock>!
    var mock: SingleWeekFormViewModelMock!
    
    override func setUpWithError() throws {
        mock = .init()
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
    
    func test_submit_success() throws {
        sut.submit()
        XCTAssertNil(mock.error)
    }
    
    func test_submit_error() throws {
        mock.showError = true
        sut.submit()
        XCTAssertTrue(mock.alertMessage == CoreError.genericError.message)
        XCTAssertTrue(mock.presentAlert)
    }
}
