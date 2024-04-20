//
//  CalendarDetailInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import XCTest

final class CalendarDetailInteractorTests: XCTestCase {
    
    var sut: CalendarDetailInteractor!
    var presenterMock: CalendarDetailPresenterMock!
    var workerMock: BillsWorkerMock!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = CalendarDetailPresenterMock()
        sut = CalendarDetailInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }
    
    func test_update_success() throws {
        sut.update(at: "2023")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_update_error() throws {
        workerMock.isError = true
        sut.update(at: "2023")
        XCTAssertTrue(presenterMock.didPresentError)
    }
}
