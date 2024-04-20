//
//  BillItemFormRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillItemFormRouterTests: XCTestCase {

    var mockNavigationController: UINavigationController!
    var sut: BillItemFormRouter!

    override func setUpWithError() throws {
        sut = BillItemFormRouter()
        mockNavigationController = UINavigationController(rootViewController: UIViewController())
        
        let mockWindow = UIWindow()
        mockWindow.rootViewController = mockNavigationController
        mockWindow.makeKeyAndVisible()
        
        let controllerMock = BillItemFormViewControllerMock(router: sut)
        
        mockNavigationController.pushViewController(controllerMock, animated: false)
        sut.viewController = controllerMock
    }

    override func tearDownWithError() throws {
        sut = nil
        mockNavigationController = nil
    }
    
    func test_close() throws {
        sut.close(animated: false)
        XCTAssertNil(mockNavigationController.topViewController as? BillItemFormViewController)
    }
}
