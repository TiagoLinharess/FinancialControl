//
//  AddWeeklyBudgetStartViewTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 02/09/23.
//
@testable import WeeklyBudgets
import SnapshotTesting
import SwiftUI
import XCTest

final class AddWeeklyBudgetStartViewTests: XCTestCase {
    
    var sut: AddWeeklyBudgetStartView!
    
    override func setUpWithError() throws {
        sut = .init()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_snapshot() throws {
        let vc = get_swiftui_view_ready_for_snapshot(view: sut)
        assertSnapshot(matching: vc, as: .image)
    }
}
