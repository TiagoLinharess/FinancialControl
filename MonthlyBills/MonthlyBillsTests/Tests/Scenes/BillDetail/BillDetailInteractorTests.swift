//
//  BillDetailInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillDetailInteractorTests: XCTestCase {
    
    var sut: BillDetailInteractor!
    var presenterMock: BillDetailPresenterMock!
    var workerMock: BillsWorkerMock!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = BillDetailPresenterMock()
        sut = BillDetailInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }
    
    func test_fetch_success() throws {
        sut.fetch(with: "id")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_fetch_error() throws {
        workerMock.isError = true
        sut.fetch(with: "id")
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_fetch_templates_success() throws {
        sut.fetchTemplates(billId: "id")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_fetch_templates_error() throws {
        workerMock.isError = true
        sut.fetchTemplates(billId: "id")
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_delete_success() throws {
        sut.delete(itemId: "id", billId: "id")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_delete_error() throws {
        workerMock.isError = true
        sut.delete(itemId: "id", billId: "id")
        XCTAssertTrue(presenterMock.didPresentError)
    }
}
