//
//  BillsWorkerTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 08/01/24.
//

@testable import MonthlyBills
import SharpnezCore
import XCTest

final class BillsWorkerTests: XCTestCase {
    
    var sut: BillsWorker!
    var mock: MonthlyBillsRepositoryMock!

    override func setUpWithError() throws {
        mock = .init()
        sut = .init(repository: mock)
    }

    override func tearDownWithError() throws {
        mock = nil
        sut = nil
    }

    func test_create_success() throws {
        XCTAssertNoThrow(try sut.create(annualCalendar: BillsMock.annualCalendar))
    }
    
    func test_create_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.create(annualCalendar: BillsMock.annualCalendar))
    }
    
    func test_create_bill_item_success() throws {
        XCTAssertNoThrow(try sut.createBillItem(item: BillsMock.incomeItem, billId: BillsMock.billIncompleteId, billType: .income))
    }
    
    func test_create_bill_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.createBillItem(item: BillsMock.incomeItem, billId: BillsMock.billIncompleteId, billType: .income))
    }
    
    func test_create_template_success() throws {
        XCTAssertNoThrow(try sut.createTemplateItem(item: BillsMock.incomeItem, billType: .income))
    }
    
    func test_create_template_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.createTemplateItem(item: BillsMock.incomeItem, billType: .income))
    }
    
    func test_read_success() throws {
        let annualCalendars = try sut.read()
        XCTAssertTrue(annualCalendars.count > 0)
    }
    
    func test_read_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.read())
    }
    
    func test_read_at_year_success() throws {
        let annualCalendar = try sut.readAtYear(year: "2023")
        XCTAssertTrue(annualCalendar.year == "2023")
    }
    
    func test_read_at_year_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readAtYear(year: "2023"))
    }
    
    func test_read_at_month_success() throws {
        let bill = try sut.readAtMonth(id: mock.billId)
        XCTAssertTrue(bill.id == mock.billId)
    }
    
    func test_read_at_month_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readAtMonth(id: mock.billId))
    }
    
    func test_read_template_success() throws {
        let templates = try sut.readTemplates()
        XCTAssertTrue(templates.count > 0)
    }
    
    func test_read_template_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readTemplates())
    }
    
    func test_read_at_month_with_templates_success() throws {
        let bill = try sut.readAtMonthWithTemplates(billId: BillsMock.billCompleteId)
        XCTAssertTrue(bill.id == BillsMock.billCompleteId)
    }
    
    func test_read_at_month_with_templates_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readAtMonthWithTemplates(billId: BillsMock.billCompleteId))
    }
    
    func test_read_template_at_item_success() throws {
        let item = try sut.readTemplateAt(id: "BillInvestmentItemViewModel")
        XCTAssertTrue(item.id == "BillInvestmentItemViewModel")
    }
    
    func test_read_template_at_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.readTemplateAt(id: "BillInvestmentItemViewModel"))
    }
    
    func test_edit_bill_success() throws {
        XCTAssertNoThrow(try sut.updateBill(bill: BillsMock.billComplete))
    }
    
    func test_edit_bill_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.updateBill(bill: BillsMock.billComplete))
    }
    
    func test_edit_bill_item_success() throws {
        XCTAssertNoThrow(try sut.updateBillItem(item: BillsMock.incomeItem, billId: BillsMock.billIncompleteId))
    }
    
    func test_edit_bill_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.updateBillItem(item: BillsMock.incomeItem, billId: BillsMock.billIncompleteId))
    }
    
    func test_edit_template_item_success() throws {
        XCTAssertNoThrow(try sut.updateTemplateItem(item: BillsMock.item))
    }
    
    func test_edit_template_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.updateTemplateItem(item: BillsMock.item))
    }
    
    func test_delete_bill_item_success() throws {
        XCTAssertNoThrow(try sut.deleteItem(itemId: BillsMock.incomeItem.id, billId: BillsMock.billIncompleteId))
    }
    
    func test_delete_bill_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.deleteItem(itemId: BillsMock.incomeItem.id, billId: BillsMock.billIncompleteId))
    }
    
    func test_delete_template_item_success() throws {
        XCTAssertNoThrow(try sut.deleteTemplateItem(itemId: BillsMock.item.id))
    }
    
    func test_delete_template_item_error() throws {
        mock.isError = true
        XCTAssertThrowsError(try sut.deleteTemplateItem(itemId: BillsMock.item.id))
    }
}
