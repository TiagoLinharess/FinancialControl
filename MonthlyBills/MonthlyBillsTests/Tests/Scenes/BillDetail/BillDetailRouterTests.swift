//
//  BillDetailRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillDetailRouterTests: XCTestCase {

    var mockNavigationController: UINavigationController!
    var sut: BillDetailRouter!

    override func setUpWithError() throws {
        sut = BillDetailRouter()
        mockNavigationController = UINavigationController(rootViewController: BillDetailViewControllerMock(router: sut))
        
        let mockWindow = UIWindow()
        mockWindow.rootViewController = mockNavigationController
        mockWindow.makeKeyAndVisible()
        
        sut.viewController = mockNavigationController.topViewController
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNavigationController = nil
    }
    
    func test_route_to_form() throws {
        sut.routeToItemForm(at: .new("id"), animated: false)
        XCTAssertNotNil(mockNavigationController.topViewController as? BillItemFormViewController)
    }
}
