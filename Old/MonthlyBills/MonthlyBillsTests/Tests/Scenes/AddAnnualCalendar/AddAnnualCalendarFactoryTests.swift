//
//  AddAnnualCalendarFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import XCTest

final class AddAnnualCalendarFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = AddAnnualCalendarFactory.configure(delegate: nil)
        XCTAssertNotNil((controller as? UINavigationController)?.topViewController as? AddAnnualCalendarViewController)
    }
}
