//
//  AddAnnualCalendarInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 13/02/24.
//

@testable import MonthlyBills
import XCTest

final class AddAnnualCalendarInteractorTests: XCTestCase {
    
    var sut: AddAnnualCalendarInteractor!
    var presenterMock: AddAnnualCalendarPresenterMock!
    var workerMock: BillsWorkerMock!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = AddAnnualCalendarPresenterMock()
        sut = AddAnnualCalendarInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }

    func test_fetch_avaliable_years() throws {
        sut.fetchAvailableYears()
        XCTAssertTrue(presenterMock.didSetYears)
    }

    func test_submit_success() throws {
        sut.submit(year: "2024")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }

    func test_submit_error() throws {
        workerMock.isError = true
        sut.submit(year: "2024")
        XCTAssertTrue(presenterMock.didPresentError)
    }

    func test_submit_empty() throws {
        sut.submit(year: "")
        XCTAssertTrue(presenterMock.didPresentError)
    }
}
