//
//  TemplateFormFactoryTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 21/02/24.
//

@testable import MonthlyBills
import XCTest

final class TemplateFormFactoryTests: XCTestCase {

    func test_get_controller() throws {
        let controller = TemplateFormFactory.configure()
        XCTAssertNotNil((controller as? UINavigationController)?.topViewController as? TemplateFormViewController)
    }
}
