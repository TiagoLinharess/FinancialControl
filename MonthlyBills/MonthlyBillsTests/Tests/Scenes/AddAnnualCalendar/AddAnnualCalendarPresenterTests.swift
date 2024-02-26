//
//  AddAnnualCalendarPresenterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 13/02/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class AddAnnualCalendarPresenterTests: XCTestCase {
    
    var sut: AddAnnualCalendarPresenter!
    var mock: AddAnnualCalendarViewControllerMock!

    override func setUpWithError() throws {
        sut = AddAnnualCalendarPresenter()
        mock = AddAnnualCalendarViewControllerMock()
        sut.viewController = mock
    }

    override func tearDownWithError() throws {
        sut = nil
        mock = nil
    }

    func test_set_years() throws {
        sut.setYears(years: ["2023"])
        XCTAssertTrue(mock.didSetYears)
    }

    func test_present_success() throws {
        sut.presentSuccess()
        XCTAssertTrue(mock.didPresentSuccess)
    }

    func test_present_error() throws {
        sut.presentError(error: CoreError.genericError)
        XCTAssertTrue(mock.didPresentError)
    }
}
