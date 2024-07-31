//
//  BillItemFormInteractorTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import XCTest

final class BillItemFormInteractorTests: XCTestCase {
    
    var sut: BillItemFormInteractor!
    var presenterMock: BillItemFormPresenterMock!
    var workerMock: BillsWorkerMock!

    override func setUpWithError() throws {
        workerMock = BillsWorkerMock()
        presenterMock = BillItemFormPresenterMock()
        sut = BillItemFormInteractor(presenter: presenterMock, worker: workerMock)
    }

    override func tearDownWithError() throws {
        workerMock = nil
        presenterMock = nil
        sut = nil
    }
    
    func test_configure_new_item() throws {
        sut.configure(formType: .new("id"))
        XCTAssertFalse(presenterMock.didPresentItem)
    }
    
    func test_configure_edit_item() throws {
        sut.configure(formType: .edit("id", "id", .income))
        XCTAssertTrue(presenterMock.didPresentItem)
    }
    
    func test_configure_new_template() throws {
        sut.configure(formType: .template)
        XCTAssertFalse(presenterMock.didPresentTemplate)
    }
    
    func test_configure_edit_template() throws {
        sut.configure(formType: .templateEdit("id", .income))
        XCTAssertTrue(presenterMock.didPresentTemplate)
    }
    
    func test_configure_edit_item_error() throws {
        workerMock.isError = true
        sut.configure(formType: .edit("id", "id", .income))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_configure_new_template_error() throws {
        workerMock.isError = true
        sut.configure(formType: .templateEdit("id", .expense))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_new_item() throws {
        sut.submit(viewModel: .init(formType: .new("id"), billType: .income, status: .payed, name: "name", validateTemplateValue: false, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_submit_edit_item() throws {
        sut.submit(viewModel: .init(formType: .edit("id", "id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_submit_item_error() throws {
        workerMock.isError = true
        sut.submit(viewModel: .init(formType: .edit("id", "id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_item_field_error() throws {
        sut.submit(viewModel: .init(formType: .edit("id", "id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: nil, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_item_installment_error() throws {
        sut.submit(viewModel: .init(formType: .edit("id", "id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: 20, validateInstallment: true, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_item_invalid_installment() throws {
        sut.submit(viewModel: .init(formType: .edit("id", "id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: false, value: 20, validateInstallment: true, installment: .init(current: 20, max: 10)))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_new_template() throws {
        sut.submit(viewModel: .init(formType: .template, billType: .income, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: true, installment: .init(current: 10, max: 12)))
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_submit_edit_template() throws {
        sut.submit(viewModel: .init(formType: .templateEdit("id", .expense), billType: .expense, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentSuccess)
    }
    
    func test_submit_template_error() throws {
        workerMock.isError = true
        sut.submit(viewModel: .init(formType: .template, billType: .expense, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_template_field_error() throws {
        sut.submit(viewModel: .init(formType: .template, billType: .expense, status: .payed, name: nil, validateTemplateValue: true, value: 200, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_template_value_error() throws {
        sut.submit(viewModel: .init(formType: .template, billType: .expense, status: .payed, name: "name", validateTemplateValue: true, value: nil, validateInstallment: false, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_template_installment_error() throws {
        sut.submit(viewModel: .init(formType: .template, billType: .expense, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: true, installment: nil))
        XCTAssertTrue(presenterMock.didPresentError)
    }
    
    func test_submit_template_installment_invalid() throws {
        sut.submit(viewModel: .init(formType: .template, billType: .expense, status: .payed, name: "name", validateTemplateValue: true, value: 200, validateInstallment: true, installment: .init(current: 20, max: 10)))
        XCTAssertTrue(presenterMock.didPresentError)
    }
}
