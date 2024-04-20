//
//  HomeInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class HomeInteractorTests: XCTestCase {
    
    var workerMock: BillsWorkerMock!
    var presenterMock: HomePresenterMock!
    var sut: HomeInteractor!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = HomePresenterMock()
        sut = HomeInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }

    func test_fetch_calendar_success() throws {
        sut.fetchCalendars()
        XCTAssertTrue(presenterMock.didPresentSuccess)
        XCTAssertTrue(presenterMock.calendars?[0].year == BillsMock.annualCalendar.year)
    }
    
    func test_fetch_calendar_error() throws {
        workerMock.isError = true
        sut.fetchCalendars()
        XCTAssertTrue(presenterMock.didPresentError)
        XCTAssertTrue(presenterMock.error != nil)
    }
}
