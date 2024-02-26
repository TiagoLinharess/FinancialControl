//
//  BillItemFormViewControllerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

import Core
import SnapshotTesting
@testable import MonthlyBills
import XCTest

final class BillItemFormViewControllerTests: XCTestCase {
    
    var interactorMock: BillItemFormInteractorMock!
    var routerMock: BillItemFormRouterMock!
    var view: BillItemFormView!
    var sut: BillItemFormViewController!
    
    override func setUpWithError() throws {
        interactorMock = BillItemFormInteractorMock()
        routerMock = BillItemFormRouterMock()
        view = BillItemFormView()
    }
    
    override func tearDownWithError() throws {
        interactorMock = nil
        routerMock = nil
        view = nil
        sut = nil
    }
    
    func setupController(type: BillItemFormType) {
        sut = BillItemFormViewController(
            formType: type,
            customView: view,
            interactor: interactorMock,
            router: routerMock
        )
        
        view.delegate = sut
    }
    
    func test_snapshot_empty() throws {
        setupController(type: .new("id"))
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_snapshot_new_item() throws {
        setupController(type: .new("id"))
        sut.presentItem(viewModel: .init(formType: .new("id"), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: 200, validateInstallment: false, installment: nil))
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }

    
    func test_snapshot_edit_item() throws {
        setupController(type: .edit("id", "id", .income))
        sut.presentItem(viewModel: .init(formType: .edit("id", "id", .creditCard), billType: .creditCard, status: .payed, name: "name", validateTemplateValue: false, value: 200, validateInstallment: true, installment: .init(current: 10, max: 20)))
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }

    
    func test_snapshot_new_template() throws {
        setupController(type: .template)
        sut.presentItem(viewModel: .init(formType: .template, billType: .creditCard, status: .payed, name: "name", validateTemplateValue: false, value: 0, validateInstallment: false, installment: nil))
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }

    
    func test_snapshot_edit_template() throws {
        setupController(type: .templateEdit("id", .income))
        sut.presentItem(viewModel: .init(formType: .templateEdit("id", .creditCard), billType: .creditCard, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: true, installment: .init(current: 10, max: 20)))
        let window = TestUtils.get_window_for_snapshot(controller: UIViewController())
        window.rootViewController?.present(UINavigationController(rootViewController: sut), animated: false)
        view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: window.rootViewController?.presentedViewController ?? sut, as: .image)
    }
    
    func test_check_action() throws {
        setupController(type: .new("id"))
        sut.checkAction()
        XCTAssertTrue(interactorMock.didSubmit)
    }
}
