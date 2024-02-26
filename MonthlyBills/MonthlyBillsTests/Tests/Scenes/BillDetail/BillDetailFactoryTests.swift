//
//  BillDetailFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillDetailFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = BillDetailFactory.configure(billId: "id")
        XCTAssertNotNil(controller as? BillDetailViewController)
    }
}
