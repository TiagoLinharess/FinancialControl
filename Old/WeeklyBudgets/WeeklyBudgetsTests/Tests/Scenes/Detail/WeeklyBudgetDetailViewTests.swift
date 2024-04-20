//
//  WeeklyBudgetDetailViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 14/11/23.
//

import Core
@testable import WeeklyBudgets
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyBudgetDetailViewTests: XCTestCase {
    
    var sut: WeeklyBudgetDetailView<WeeklyBudgetDetailViewModel>!
    var mock: WeeklyBudgetViewModel!
    
    override func setUpWithError() throws {
        mock = WeeklyBudgetViewModelMock.getOne()
        sut = .init(viewModel: WeeklyBudgetDetailViewModel(weekBudget: mock))
    }
    
    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_snapshot() throws {
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_expenses() throws {
        mock.addExpense(expense: .init(title: "iphone", description: "", paymentMode: .credit, value: 10))
        
        let vc = TestUtils.get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
}
