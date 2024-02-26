//
//  CalendarDetailViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

import Core
import SnapshotTesting
@testable import MonthlyBills
import XCTest

final class CalendarDetailViewControllerTests: XCTestCase {

    var interactorMock: CalendarDetailInteractorMock!
    var routerMock: CalendarDetailRouterMock!
    var view: CalendarDetailView!
    var sut: CalendarDetailViewController!

    override func setUpWithError() throws {
        interactorMock = CalendarDetailInteractorMock()
        routerMock = CalendarDetailRouterMock()
        view = CalendarDetailView()
        sut = CalendarDetailViewController(
            currentYear: "2023",
            customView: view,
            interactor: interactorMock,
            router: routerMock
        )
        view.delegate = sut
    }

    override func tearDownWithError() throws {
        interactorMock = nil
        routerMock = nil
        view = nil
        sut = nil
    }
    
    func test_snapshot() throws {
        sut.presentSuccess(newCalendar: BillsMock.annualCalendar)
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_did_select_month() throws {
        sut.presentSuccess(newCalendar: BillsMock.annualCalendar)
        view.tableView(view.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(routerMock.didRouteToBill)
    }
    
    func test_cancel_action() throws {
        sut.cancelAction()
        XCTAssertTrue(routerMock.didClose)
    }
}
