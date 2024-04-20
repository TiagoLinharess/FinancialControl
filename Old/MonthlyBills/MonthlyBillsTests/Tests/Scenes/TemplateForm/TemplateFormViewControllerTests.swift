//
//  TemplateFormViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

import Core
import SnapshotTesting
@testable import MonthlyBills
import XCTest

final class TemplateFormViewControllerTests: XCTestCase {
    
    var interactorMock: TemplateFormInteractorMock!
    var routerMock: TemplateFormRouterMock!
    var view: TemplateFormView!
    var sut: TemplateFormViewController!

    override func setUpWithError() throws {
        interactorMock = TemplateFormInteractorMock()
        routerMock = TemplateFormRouterMock()
        view = TemplateFormView()
        sut = TemplateFormViewController(customView: view, interactor: interactorMock, router: routerMock)
        view.delegate = sut
    }

    override func tearDownWithError() throws {
        interactorMock = nil
        routerMock = nil
        view = nil
        sut = nil
    }
    
    func test_snapshot_empty() throws {
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_snapshot_success() throws {
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_snapshot_with_delegate_nil() throws {
        view.delegate = nil
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_set_error() throws {
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        sut.presentError(errorMessage: "test error")
        XCTAssertNotNil((window.rootViewController?.presentedViewController as? UINavigationController)?.topViewController?.sheetPresentationController)
    }
    
    func test_set_templates() throws {
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        XCTAssertTrue(sut.getTemplates().count == 2)
    }
    
    func test_select() throws {
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        view.tableView(view.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(routerMock.didRouteToForm)
    }
    
    func test_select_with_delegate_nil() throws {
        view.delegate = nil
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        view.tableView(view.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertFalse(routerMock.didRouteToForm)
    }
    
    func test_delete() throws {
        sut.presentSuccess(templates: [BillsMock.incomeSection, BillsMock.expenseSection])
        view.tableView(view.tableView, commit: .delete, forRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(interactorMock.didDelete)
    }
    
    func test_did_tap_add() throws {
        sut.didTapAddButton()
        XCTAssertTrue(routerMock.didRouteToForm)
    }
    
    func test_did_tap_cancel() throws {
        sut.cancelAction()
        XCTAssertTrue(routerMock.didClose)
    }
}
