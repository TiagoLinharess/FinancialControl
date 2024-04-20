//
//  String+ExtensionsTests.swift
//  CoreTests
//
//  Created by Tiago Linhares on 17/11/23.
//

@testable import Core
import XCTest

final class StringExtensionsTests: XCTestCase {

    func test_valid_value() throws {
        let sut = "$99.99"
        XCTAssertTrue(sut.currencyToDouble == 99.99)
    }
    
    func test_invalid_value() throws {
        let sut = "invalid value"
        XCTAssertTrue(sut.currencyToDouble == nil)
    }
}
