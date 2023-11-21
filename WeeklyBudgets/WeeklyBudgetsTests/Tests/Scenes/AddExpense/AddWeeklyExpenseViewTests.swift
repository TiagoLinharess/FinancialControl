//
//  AddWeeklyExpenseViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import SnapshotTesting
import SwiftUI
import XCTest

final class AddWeeklyExpenseViewTests: XCTestCase {
    
    var sut: AddWeeklyExpenseView<AddWeeklyExpenseViewModelMock>!
    var mock: AddWeeklyExpenseViewModelMock!
    var router: WeeklyDetailRouter!
    
    override func setUpWithError() throws {
        router = .init()
        mock = .init()
        sut = .init(viewModel: mock, router: router)
    }
    
    override func tearDownWithError() throws {
        router = nil
        mock = nil
        sut = nil
    }

    func test_snapshot() throws {
        let vc = get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_submit_success() throws {
        mock.isError = false
        sut.submit()
        
        XCTAssertTrue(mock.presentAlert)
        XCTAssertTrue(mock.alertMessage == "Expense added with success")
    }
    
    func test_submit_error() throws {
        mock.isError = true
        sut.submit()
        
        XCTAssertTrue(mock.presentAlert)
        XCTAssertTrue(mock.alertMessage == CoreError.genericError.message)
    }
}
