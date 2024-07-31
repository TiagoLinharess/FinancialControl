//
//  WeeklyBudgetsHomeViewTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 02/09/23.
//

import Core
@testable import WeeklyBudgets
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyBudgetsHomeViewTests: XCTestCase {
    
    var sut: WeeklyBudgetsHomeView<WeeklyBudgetsHomeViewModelMock>!
    var mock: WeeklyBudgetsHomeViewModelMock!
    
    override func setUpWithError() throws {
        mock = .init(
            viewStatus: .empty,
            budgets: [],
            addBudgetFlowPresented: false
        )
        sut = .init(viewModel: mock)
    }
    
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_snapshot_empty() throws {
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_budget() throws {
        mock.viewStatus = .success
        mock.budgets = WeeklyBudgetViewModelMock.getThree()
        
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_error() throws {
        mock.viewStatus = .error("Error")
        
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_addBudgetFlowPresented() throws {
        mock.viewStatus = .error("Error")
        mock.addBudgetFlowPresented = true
        
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
}
