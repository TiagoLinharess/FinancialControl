//
//  WeeklyNavigationOptionTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

@testable import WeeklyBudgets
import SwiftUI
import XCTest

final class WeeklyNavigationOptionTests: XCTestCase {

    func test_equal() throws {
        let sut0 = WeeklyNavigationOption.singleWeekForm
        let sut1 = WeeklyNavigationOption.review([])
        
        XCTAssertTrue(sut0 != sut1)
    }
}
