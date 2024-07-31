//
//  BillItemFormPresenterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class BillItemFormPresenterTests: XCTestCase {

    var mockController: BillItemFormViewControllerMock!
    var sut: BillItemFormPresenter!

    override func setUpWithError() throws {
        mockController = BillItemFormViewControllerMock()
        sut = BillItemFormPresenter()
        sut.viewController = mockController
    }

    override func tearDownWithError() throws {
        mockController = nil
        sut = nil
    }
    
    func test_present_success() throws {
        sut.presentSuccess()
        XCTAssertTrue(mockController.didPresentSuccess)
    }
    
    func test_present_item() throws {
        sut.presentItem(bill: BillsMock.billComplete, itemId: BillsMock.incomeSection.items[0].id, sectionType: .income)
        XCTAssertTrue(mockController.didPresentItem)
    }
    
    func test_present_item_error() throws {
        sut.presentItem(bill: BillsMock.billComplete, itemId: "noid", sectionType: .income)
        XCTAssertTrue(mockController.didPresentError)
    }
    
    func test_present_template() throws {
        sut.presentTemplate(templateItem: BillsMock.template, sectionType: .expense)
        XCTAssertTrue(mockController.didPresentItem)
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
