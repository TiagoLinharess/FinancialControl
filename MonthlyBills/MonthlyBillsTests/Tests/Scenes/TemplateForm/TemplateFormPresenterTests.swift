//
//  TemplateFormPresenterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class TemplateFormPresenterTests: XCTestCase {

    var mockController: TemplateFormViewControllerMock!
    var sut: TemplateFormPresenter!

    override func setUpWithError() throws {
        mockController = TemplateFormViewControllerMock()
        sut = TemplateFormPresenter()
        sut.viewController = mockController
    }

    override func tearDownWithError() throws {
        mockController = nil
        sut = nil
    }
    
    func test_present_success() throws {
        sut.presentSuccess(templates: [BillsMock.incomeSection])
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
