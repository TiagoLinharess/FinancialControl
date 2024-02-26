//
//  BillDetailViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

import Core
import SnapshotTesting
@testable import MonthlyBills
import XCTest

final class BillDetailViewControllerTests: XCTestCase {

    var interactorMock: BillDetailInteractorMock!
    var routerMock: BillDetailRouterMock!
    var view: BillDetailView!
    var sut: BillDetailViewController!

    override func setUpWithError() throws {
        interactorMock = BillDetailInteractorMock()
        routerMock = BillDetailRouterMock()
        view = BillDetailView()
        sut = BillDetailViewController(
            billId: "id",
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
        sut.presentSuccess(newBill: BillsMock.billComplete)
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_snapshot_empty() throws {
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_select_row() throws {
        sut.presentSuccess(newBill: BillsMock.billComplete)
        view.tableView(view.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(routerMock.didRouteToForm)
    }
    
    func test_delete_row() throws {
        sut.presentSuccess(newBill: BillsMock.billComplete)
        view.tableView(view.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(interactorMock.deleteCalled)
    }
    
    func test_add_template_without_bill() throws {
        sut.didTapTemplateButton()
        XCTAssertTrue(interactorMock.fetchTemplatesCalled)
    }
    
    func test_add_template_with_bill() throws {
        sut.presentSuccess(newBill: BillsMock.billComplete)
        sut.didTapTemplateButton()
        XCTAssertFalse(interactorMock.fetchTemplatesCalled)
    }
    
    func test_add_bill() throws {
        sut.presentSuccess(newBill: BillsMock.billComplete)
        sut.addAction()
        XCTAssertTrue(routerMock.didRouteToForm)
    }
}
