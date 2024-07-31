//
//  CalendarDetailRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import XCTest

final class CalendarDetailRouterTests: XCTestCase {
    
    var mockBaseController: HomeMockController!
    var mockNavigationController: UINavigationController!
    var sut: CalendarDetailRouter!

    override func setUpWithError() throws {
        sut = CalendarDetailRouter()
        mockNavigationController = UINavigationController(rootViewController: CalendarDetailViewControllerMock(router: sut))
        mockBaseController = HomeMockController()
        
        let mockWindow = UIWindow()
        mockWindow.rootViewController = mockBaseController
        mockWindow.makeKeyAndVisible()
        
        sut.viewController = mockNavigationController.topViewController
        mockBaseController.present(mockNavigationController, animated: false)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockBaseController = nil
        mockNavigationController = nil
    }
    
    func test_route_to_bill() throws {
        sut.routeToBill(billId: "id", animated: false)
        XCTAssertTrue(mockNavigationController.topViewController is BillDetailViewController)
    }
}
