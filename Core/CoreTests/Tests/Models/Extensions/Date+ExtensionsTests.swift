//
//  Date+ExtensionsTests.swift
//  CoreTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import Core
import XCTest

final class DateExtensionsTests: XCTestCase {

    func test_locale_format_success() throws {
        let string = "29 October 2019 20:15:55 +0200"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
        let localeFormat = dateFormatter.date(from: string)?.localeFormat ?? Date().localeFormat
        
        XCTAssertTrue(localeFormat == "10/29/19")
    }
}
