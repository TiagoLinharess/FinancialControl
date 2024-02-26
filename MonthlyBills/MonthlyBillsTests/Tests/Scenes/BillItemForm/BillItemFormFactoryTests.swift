//
//  BillItemFormFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillItemFormFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = BillItemFormFactory.configure(formType: .new("id"))
        XCTAssertNotNil(controller as? BillItemFormViewController)
    }
}
