//
//  TemplateFormRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 21/02/24.
//

@testable import MonthlyBills
import XCTest

final class TemplateFormRouterTests: XCTestCase {

    var mockBaseController: HomeMockController!
    var mockNavigationController: UINavigationController!
    var sut: TemplateFormRouter!

    override func setUpWithError() throws {
        sut = TemplateFormRouter()
        mockNavigationController = UINavigationController(rootViewController: TemplateFormViewControllerMock(router: sut))
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

    func test_route_to_item_form() throws {
        sut.routeToItemForm(at: .template, animated: false)
        XCTAssertTrue(mockNavigationController.topViewController is BillItemFormViewController)
    }
}
