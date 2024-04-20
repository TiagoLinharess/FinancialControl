//
//  BillDetailPresenterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class BillDetailPresenterTests: XCTestCase {

    var mockController: BillDetailViewControllerMock!
    var sut: BillDetailPresenter!

    override func setUpWithError() throws {
        mockController = BillDetailViewControllerMock()
        sut = BillDetailPresenter()
        sut.viewController = mockController
    }

    override func tearDownWithError() throws {
        mockController = nil
        sut = nil
    }
    
    func test_present_success() throws {
        sut.presentSuccess(newBill: BillsMock.billComplete)
        XCTAssertTrue(mockController.didPresentSuccess)
    }
    
    func test_present_error() throws {
        sut.presentError(error: CoreError.genericError)
        XCTAssertTrue(mockController.didPresentError)
    }
    
    func test_present_error_as_nserror() throws {
        sut.presentError(error: NSError(domain: "domain", code: -23))
        XCTAssertTrue(mockController.didPresentError)
    }
}
