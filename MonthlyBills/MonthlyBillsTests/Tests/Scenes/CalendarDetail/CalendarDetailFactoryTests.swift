//
//  CalendarDetailFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import XCTest

final class CalendarDetailFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = CalendarDetailFactory.configure(year: "2023")
        XCTAssertNotNil((controller as? UINavigationController)?.topViewController as? CalendarDetailViewController)
    }
}
