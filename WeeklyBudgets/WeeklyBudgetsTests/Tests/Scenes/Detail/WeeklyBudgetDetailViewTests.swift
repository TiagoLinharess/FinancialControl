//
//  WeeklyBudgetDetailViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 14/11/23.
//

@testable import WeeklyBudgets
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyBudgetDetailViewTests: XCTestCase {

    func test_snapshot() throws {
        let sut = WeeklyBudgetDetailView(viewModel: WeeklyBudgetDetailViewModel(weekBudget: WeeklyBudgetViewModelMock.getOne()))
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_snapshot_with_expenses() throws {
        let mock = WeeklyBudgetViewModelMock.getOne()
        mock.addExpense(expense: .init(title: "iphone", description: "", paymentMode: .credit, value: 10))
        
        let sut = WeeklyBudgetDetailView(viewModel: WeeklyBudgetDetailViewModel(weekBudget: mock))
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
}
