//
//  HomeViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

import Core
@testable import MonthlyBills
import SharpnezCore
import SnapshotTesting
import XCTest

final class HomeViewControllerTests: XCTestCase {
    
    var routerMock: HomeRouterMock!
    var interactorMock: HomeInteractorMock!
    var sut: HomeViewController!

    override func setUpWithError() throws {
        let view = HomeView()
        routerMock = HomeRouterMock()
        interactorMock = HomeInteractorMock()
        sut = HomeViewController(customView: view, interactor: interactorMock, router: routerMock)
        
        view.delegate = sut
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
        routerMock = nil
    }
    
    func test_snapshot_success() throws {
        sut.presentSuccess(calendars: [BillsMock.annualCalendar])
        let window = TestUtils.get_window_for_snapshot(controller: sut)
        assertSnapshot(matching: window.rootViewController ?? sut, as: .image)
    }
    
    func test_snapshot_empty() throws {
        sut.presentEmpty()
        let window = TestUtils.get_window_for_snapshot(controller: sut)
        assertSnapshot(matching: window.rootViewController ?? sut, as: .image)
    }
    
    func test_snapshot_error() throws {
        sut.presentError(message: "test error")
        let window = TestUtils.get_window_for_snapshot(controller: sut)
        assertSnapshot(matching: window.rootViewController ?? sut, as: .image)
    }
    
    func test_view_did_load() throws {
        sut.viewDidLoad()
        let window = TestUtils.get_window_for_snapshot(controller: sut)
        XCTAssertTrue(interactorMock.didFetchCalendars)
        assertSnapshot(matching: window.rootViewController ?? sut, as: .image)
    }
    
    func test_present_success() throws {
        sut.presentSuccess(calendars: [BillsMock.annualCalendar])
        XCTAssertTrue(sut.getCalendars()[0].year == BillsMock.annualCalendar.year)
    }

    func test_did_tap_add_button() throws {
        sut.didTapAddButton()
        XCTAssertTrue(routerMock.didRouteToAdd)
    }
    
    func test_did_select_calendar() throws {
        sut.presentSuccess(calendars: [BillsMock.annualCalendar])
        sut.customView.tableView(sut.customView.tableView, didSelectRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(routerMock.didRouteToDetail)
    }
    
    func test_error_action() throws {
        sut.presentError(message: "test error")
        sut.customView.delegate?.errorAction()
        XCTAssertTrue(interactorMock.didFetchCalendars)
    }
    
    func test_did_add_bill() throws {
        sut.didAddBill()
        XCTAssertTrue(interactorMock.didFetchCalendars)
    }
    
    func test_did_tap_template_button() throws {
        sut.didTapTemplateButton()
        XCTAssertTrue(routerMock.didRouteToTemplate)
    }
}
