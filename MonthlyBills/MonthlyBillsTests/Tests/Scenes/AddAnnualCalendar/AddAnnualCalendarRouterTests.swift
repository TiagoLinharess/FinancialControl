//
//  AddAnnualCalendarRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import XCTest

final class AddAnnualCalendarRouterTests: XCTestCase {
    
    var mockBaseController: HomeMockController!
    var sut: AddAnnualCalendarRouter!

    override func setUpWithError() throws {
        sut = AddAnnualCalendarRouter()
        mockBaseController = HomeMockController()
        
        let mockController = UINavigationController(rootViewController: AddAnnualCalendarViewControllerMock(router: sut))
        
        let mockWindow = UIWindow()
        mockWindow.rootViewController = mockBaseController
        
        sut.viewController = mockController.topViewController
        sut.addBillDelegate = mockBaseController
        mockBaseController.present(mockController, animated: true)
        
        mockWindow.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockBaseController = nil
    }
    
    func test_close() throws {
        sut.close()
        XCTAssertNil(self.mockBaseController.presentedViewController)
    }
    
    func test_finish() throws {
        sut.finish()
        XCTAssertNil(self.mockBaseController.presentedViewController)
        XCTAssertTrue(mockBaseController.didAddBillCalled)
    }
}
