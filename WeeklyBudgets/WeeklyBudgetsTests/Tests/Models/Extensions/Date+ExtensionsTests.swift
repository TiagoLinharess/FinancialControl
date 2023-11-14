//
//  Date+ExtensionsTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import WeeklyBudgets
import XCTest

final class DateExtensionsTests: XCTestCase {

    func test_locale_format_success() throws {
        let firstString = "29 October 2019"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let date = dateFormatter.date(from: firstString) ?? Date()
        let weekday = date.firstWeekDayOfMonth(with: 1)
        
        let stringToCompare = "13 October 2019"
        let dateFormatterToCompare = DateFormatter()
        dateFormatterToCompare.dateFormat = "dd MMM yyyy"
        let dateToCompare = dateFormatterToCompare.date(from: stringToCompare) ?? Date()
        
        XCTAssertTrue(weekday[1] == dateToCompare)
    }
}
