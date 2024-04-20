//
//  AddAnnualCalendarViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 13/02/24.
//

import Core
@testable import MonthlyBills
import SnapshotTesting
import XCTest

final class AddAnnualCalendarViewControllerTests: XCTestCase {
    
    var interactorMock: AddAnnualCalendarInteractorMock!
    var routerMock: AddAnnualCalendarRouterMock!
    var view: AddAnnualCalendarView!
    var sut: AddAnnualCalendarViewController!

    override func setUpWithError() throws {
        interactorMock = AddAnnualCalendarInteractorMock()
        routerMock = AddAnnualCalendarRouterMock()
        view = AddAnnualCalendarView()
        sut = AddAnnualCalendarViewController(customView: view, interactor: interactorMock, router: routerMock)
    }

    override func tearDownWithError() throws {
        interactorMock = nil
        routerMock = nil
        view = nil
        sut = nil
    }

    func test_snapshot_set_years() throws {
        sut.setYears(years: ["2023", "2024", "2025"])
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_cancel_action() throws {
        sut.cancelAction()
        XCTAssertTrue(routerMock.didClose)
    }
    
    func test_done_action() throws {
        sut.setYears(years: ["2023", "2024", "2025"])
        sut.doneAction()
        XCTAssertTrue(interactorMock.didSubmit)
    }
    
    func test_finish_action() throws {
        sut.setYears(years: ["2023", "2024", "2025"])
        sut.finishAction()
        XCTAssertTrue(routerMock.didFinish)
    }
}
