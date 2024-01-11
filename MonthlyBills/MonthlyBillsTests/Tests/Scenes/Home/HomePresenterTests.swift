//
//  HomePresenterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class HomePresenterTests: XCTestCase {
    
    var mockController: HomeMockController!
    var sut: HomePresenter!

    override func setUpWithError() throws {
        mockController = HomeMockController()
        sut = HomePresenter()
        sut.viewController = mockController
    }

    override func tearDownWithError() throws {
        mockController = nil
        sut = nil
    }

    func test_present_success() throws {
        sut.presentSuccess(calendars: [BillsMock.annualCalendar])
        XCTAssertTrue(mockController.didPresentSuccess)
        XCTAssertTrue(mockController.calendars.count == 1)
        XCTAssertTrue(mockController.calendars[0].year == "2023")
    }
    
    func test_present_empty() throws {
        sut.presentSuccess(calendars: [])
        XCTAssertTrue(mockController.didPresentEmpty)
        XCTAssertTrue(mockController.calendars.count == 0)
    }
    
    func test_present_error() throws {
        sut.presentError(error: CoreError.customError("test error"))
        XCTAssertTrue(mockController.didPresentError)
        XCTAssertTrue(mockController.calendars.count == 0)
        XCTAssertTrue(mockController.errorMessage == "test error")
    }
}
