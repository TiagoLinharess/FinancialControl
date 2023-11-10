//
//  WeeklyBudgetsHomeViewTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 02/09/23.
//
@testable import WeeklyBudgets
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyBudgetsHomeViewTests: XCTestCase {

    func test_snapshot_empty() throws {
        let sut = WeeklyBudgetsHomeView(viewModel: WeeklyBudgetsHomeViewModel())
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_budget() throws {
        let viewModel = WeeklyBudgetsHomeViewModelMock(
            viewStatus: .success,
            budgets: WeeklyBudgetViewModelMock.getThree(),
            addBudgetFlowPresented: false
        )
        let sut = WeeklyBudgetsHomeView(viewModel: viewModel)
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_error() throws {
        let viewModel = WeeklyBudgetsHomeViewModelMock(
            viewStatus: .error("Error"),
            budgets: [],
            addBudgetFlowPresented: false
        )
        let sut = WeeklyBudgetsHomeView(viewModel: viewModel)
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
}
