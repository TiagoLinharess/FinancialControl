//
//  AddWeeklyBudgetStartViewTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 02/09/23.
//
@testable import Financial_Control
import SnapshotTesting
import SwiftUI
import XCTest

final class AddWeeklyBudgetStartViewTests: XCTestCase {

    func test_snapshot() throws {
        let sut = AddWeeklyBudgetStartView()
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
}
