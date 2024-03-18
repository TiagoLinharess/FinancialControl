//
//  MonthlyBillsRepositoryTests.swift
//  ProviderTests
//
//  Created by Tiago Linhares on 01/12/23.
//

@testable import Provider
import XCTest
import SharpnezCore

final class MonthlyBillsRepositoryTests: XCTestCase {
    
    let annualCalendarMock: AnnualCalendarResponse = .init(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", sections: [.init(items: [.init(id: UUID().uuidString, name: "bill", value: 100, status: .payed, installment: .init(current: 1, max: 10))], type: .expense)])])
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_existent_week")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_item_in_new_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_item_in_income_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_item_in_existent_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_template_item_in_new_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_template_item_in_income_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_template_item_in_existent_section")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_empty")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_with_templates_success1")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_with_templates_error1")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_with_templates_success2")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_with_templates_error2")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_template")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_template_empty")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_template_at_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_template_at_item_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_bill_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_bill_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_without_bill")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_without_existent_item")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_template_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_template_item_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_without_bill")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_without_existent_item")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_template_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_template_item_without_existent_item")
    }
    
    // MARK: Test Key
    
    func test_key() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_key")
        XCTAssertTrue(sut.key == "MonthlyBillsRepository_test_key")
    }
    
    func test_key_nil() throws {
        let sut = MonthlyBillsProvider()
        XCTAssertTrue(sut.key == Constants.UserDefaultsKeys.bills)
    }
    
    func test_template_key() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_template_key")
        XCTAssertTrue(sut.templateKey == "MonthlyBillsRepository_test_template_key")
    }
    
    func test_template_key_nil() throws {
        let sut = MonthlyBillsProvider()
        XCTAssertTrue(sut.templateKey == Constants.UserDefaultsKeys.billsTemplate)
    }
    
    // MARK: Create
    
    func test_create_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_create")
        XCTAssertNoThrow(try sut.create(annualCalendar: annualCalendarMock))
    }
    
    func test_create_existent_week() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_create_existent_week")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        
        XCTAssertThrowsError(try sut.create(annualCalendar: .init(year: "2023", monthlyBills: [])))
    }
    
    func test_create_item_in_new_section() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_create_item_in_new_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .investment))
    }
    
    func test_create_item_in_income_section() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_create_item_in_income_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .income))
    }
    
    func test_create_item_in_existent_section() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_create_item_in_existent_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .expense))
    }
    
    func test_create_template_item_in_new_section() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_create_template_item_in_new_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 0, status: .pending, installment: nil)
        
        XCTAssertNoThrow(try sut.createTemplateItem(item: response, billType: .expense))
    }
    
    func test_create_template_item_in_income_section() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_create_template_item_in_income_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .pending, installment: nil)
        try sut.createTemplateItem(item: .init(id: "", name: "bill", value: 0, status: .pending, installment: nil), billType: .creditCard)
        
        XCTAssertNoThrow(try sut.createTemplateItem(item: response, billType: .income))
    }
    
    func test_create_template_item_in_existent_section() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_create_template_item_in_existent_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .pending, installment: nil)
        try sut.createTemplateItem(item: .init(id: "", name: "bill", value: 0, status: .pending, installment: nil), billType: .creditCard)
        
        XCTAssertNoThrow(try sut.createTemplateItem(item: response, billType: .creditCard))
    }
    
    // MARK: Read
    
    func test_read() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        let response = try sut.read()
        
        XCTAssertTrue(response[0].year == "2023")
    }
    
    func test_read_empty() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_empty")
        let response = try sut.read()
    
        XCTAssertTrue(response.isEmpty)
    }
    
    func test_read_at_year_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_year_success")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        let matchingCalendar = try sut.readAtYear(year: "2023")
        
        XCTAssertTrue(matchingCalendar.year == "2023")
    }
    
    func test_read_at_year_error() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_year_error")
        XCTAssertThrowsError(try sut.readAtYear(year: "2023"))
    }
    
    func test_read_at_month_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_month_success")
        let calendar = AnnualCalendarResponse(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", sections: [])])
        try sut.create(annualCalendar: calendar)
        let matchingBill = try sut.readAtMonth(id: calendar.monthlyBills[0].id)
        
        XCTAssertTrue(matchingBill.id == calendar.monthlyBills[0].id)
    }
    
    func test_read_at_month_error() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_month_error")
        XCTAssertThrowsError(try sut.readAtMonth(id: UUID().uuidString))
    }
    
    func test_read_at_month_with_templates_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_month_with_templates_success1", templateKey: "MonthlyBillsRepository_test_read_at_month_with_templates_success2")
        try sut.create(annualCalendar: annualCalendarMock)
        try sut.createTemplateItem(item: .init(id: "id", name: "name", value: 200, status: .pending, installment: nil), billType: .income)
        let matchingBill = try sut.readAtMonthWithTemplates(billId: annualCalendarMock.monthlyBills[0].id)
        
        XCTAssertTrue(matchingBill.id == annualCalendarMock.monthlyBills[0].id)
        XCTAssertTrue(matchingBill.sections[0].items[0].id == "id")
    }
    
    func test_read_at_month_with_templates_error() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_read_at_month_with_templates_error1", templateKey: "MonthlyBillsRepository_test_read_at_month_with_templates_error2")
        XCTAssertThrowsError(try sut.readAtMonthWithTemplates(billId: UUID().uuidString))
    }
    
    func test_read_template() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_read_template")
        try sut.createTemplateItem(item: .init(id: "", name: "bill", value: 0, status: .pending, installment: nil), billType: .creditCard)
        let response = try sut.readTemplates()
        
        XCTAssertTrue(response[0].items.count > 0)
    }
    
    func test_read_template_empty() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_read_template_empty")
        let response = try sut.readTemplates()
    
        XCTAssertTrue(response.isEmpty)
    }
    
    func test_read_template_at_item_success() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_read_template_at_item_success")
        try sut.createTemplateItem(item: .init(id: "id", name: "bill", value: 0, status: .pending, installment: nil), billType: .creditCard)
        let matchingItem = try sut.readTemplateAt(id: "id")
        
        XCTAssertTrue(matchingItem.id == "id")
    }
    
    func test_read_template_at_item_error() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_read_template_at_item_error")
        XCTAssertThrowsError(try sut.readTemplateAt(id: "id"))
    }
    
    // MARK: Update
    
    func test_update_item_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_update_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_update_item_without_bill() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_update_item_without_bill")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        
        XCTAssertThrowsError(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_update_item_without_existent_item() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_update_item_without_existent_item")
        let itemToEdit = BillItemResponse(id: UUID().uuidString, name: "", value: 40000, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertThrowsError(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_update_template_item_success() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_update_template_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        try sut.createTemplateItem(item: item, billType: .expense)
        
        XCTAssertNoThrow(try sut.updateTemplateItem(item: itemToEdit))
    }
    
    func test_update_template_item_error() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_update_template_item_error")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        
        XCTAssertThrowsError(try sut.updateTemplateItem(item: itemToEdit))
    }
    
    // MARK: Delete
    
    func test_delete_item_success() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_delete_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.deleteItem(itemId: item.id, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_delete_item_without_bill() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_delete_item_without_bill")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        
        XCTAssertThrowsError(try sut.deleteItem(itemId: item.id, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_delete_item_without_existent_item() throws {
        let sut = MonthlyBillsProvider(key: "MonthlyBillsRepository_test_delete_item_without_existent_item")
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertThrowsError(try sut.deleteItem(itemId: UUID().uuidString, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_delete_template_item_success() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_delete_template_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        try sut.createTemplateItem(item: item, billType: .expense)
        
        XCTAssertNoThrow(try sut.deleteTemplateItem(itemId: item.id))
    }
    
    func test_delete_template_item_without_existent_item() throws {
        let sut = MonthlyBillsProvider(templateKey: "MonthlyBillsRepository_test_delete_template_item_without_existent_item")
        
        XCTAssertThrowsError(try sut.deleteTemplateItem(itemId: "id"))
    }
}
