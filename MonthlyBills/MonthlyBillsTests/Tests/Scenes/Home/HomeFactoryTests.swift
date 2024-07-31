//
//  HomeFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import XCTest

final class HomeFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = HomeFactory.configure()
        XCTAssertNotNil(controller as? HomeViewController)
    }
}
