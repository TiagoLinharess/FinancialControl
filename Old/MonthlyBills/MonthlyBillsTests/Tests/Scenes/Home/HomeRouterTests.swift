//
//  HomeRouterTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class HomeRouterTests: XCTestCase {
    
    var sut: HomeRouter!
    var mockController: HomeMockController!

    override func setUpWithError() throws {
        sut = HomeRouter()
        mockController = HomeMockController(router: sut)
        let mockWindow = UIWindow()
        let navigation = UINavigationController(rootViewController: mockController)
        
        mockWindow.rootViewController = navigation
        sut.viewController = mockController
        mockWindow.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockController = nil
    }

    func test_route_to_add() throws {
        sut.routeToAdd(delegate: mockController)
        XCTAssertTrue((sut.viewController?.navigationController?.presentedViewController as? UINavigationController)?.topViewController is AddAnnualCalendarViewController)
    }
    
    func test_route_to_detail() throws {
        sut.routeToDetail(year: "2023")
        XCTAssertTrue((sut.viewController?.navigationController?.presentedViewController as? UINavigationController)?.topViewController is CalendarDetailViewController)
    }
    
    func test_route_to_template() throws {
        sut.routeToTemplate()
        XCTAssertTrue((sut.viewController?.navigationController?.presentedViewController as? UINavigationController)?.topViewController is TemplateFormViewController)
    }
}
