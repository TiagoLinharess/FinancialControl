//
//  Double+ExtensionsTests.swift
//  CoreTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import Core
import XCTest

final class DoubleExtensionsTests: XCTestCase {

    func test_to_currency_success() throws {
        let sut: Double = 999999.99
        let currency = sut.toCurrency()
        XCTAssertTrue(currency == "$999,999.99")
    }
    
    func test_to_currency_error() throws {
        let sut: Double = .signalingNaN
        let currency = sut.toCurrency()
        XCTAssertTrue(currency == "NaN")
    }
}
