//
//  TemplateFormInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

@testable import MonthlyBills
import XCTest

final class TemplateFormInteractorTests: XCTestCase {

    var sut: TemplateFormInteractor!
    var presenterMock: TemplateFormPresenterMock!
    var workerMock: BillsWorkerMock!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = TemplateFormPresenterMock()
        sut = TemplateFormInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }
    
    func test_fetch_success() throws {
        sut.fetch()
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_fetch_error() throws {
        workerMock.isError = true
        sut.fetch()
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_delete_success() throws {
        sut.delete(at: "id")
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_delete_error() throws {
        workerMock.isError = true
        sut.delete(at: "id")
        XCTAssertTrue(presenterMock.didPresentError)
    }
}
