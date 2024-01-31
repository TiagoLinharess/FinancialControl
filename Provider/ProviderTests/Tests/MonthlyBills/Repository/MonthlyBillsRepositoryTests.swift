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
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_empty")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_without_bill")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_item_without_existent_item")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_without_bill")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_delete_item_without_existent_item")
    }
    
    // MARK: Test Key
    
    func test_key() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_key")
        XCTAssertTrue(sut.key == "MonthlyBillsRepository_test_key")
    }
    
    func test_key_nil() throws {
        let sut = MonthlyBillsRepository()
        XCTAssertTrue(sut.key == Constants.UserDefaultsKeys.bills)
    }
    
    // MARK: Create
    
    func test_create_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create")
        XCTAssertNoThrow(try sut.create(annualCalendar: annualCalendarMock))
    }
    
    func test_create_existent_week() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create_existent_week")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        
        XCTAssertThrowsError(try sut.create(annualCalendar: .init(year: "2023", monthlyBills: [])))
    }
    
    func test_create_item_in_new_section() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create_item_in_new_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .investment))
    }
    
    func test_create_item_in_income_section() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create_item_in_income_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .income))
    }
    
    func test_create_item_in_existent_section() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create_item_in_existent_section")
        let response = BillItemResponse(id: "test", name: "bill2", value: 300, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.createBillItem(item: response, billId: annualCalendarMock.monthlyBills[0].id, billType: .expense))
    }
    
    // MARK: Read
    
    func test_read() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        let response = try sut.read()
        
        XCTAssertTrue(response[0].year == "2023")
    }
    
    func test_read_empty() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_empty")
        let response = try sut.read()
    
        XCTAssertTrue(response.isEmpty)
    }
    
    func test_read_at_year_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_year_success")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        let matchingCalendar = try sut.readAtYear(year: "2023")
        
        XCTAssertTrue(matchingCalendar.year == "2023")
    }
    
    func test_read_at_year_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_year_error")
        XCTAssertThrowsError(try sut.readAtYear(year: "2023"))
    }
    
    func test_read_at_month_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_month_success")
        let calendar = AnnualCalendarResponse(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", sections: [])])
        try sut.create(annualCalendar: calendar)
        let matchingBill = try sut.readAtMonth(id: calendar.monthlyBills[0].id)
        
        XCTAssertTrue(matchingBill.id == calendar.monthlyBills[0].id)
    }
    
    func test_read_at_month_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_month_error")
        XCTAssertThrowsError(try sut.readAtMonth(id: UUID().uuidString))
    }
    
    // MARK: Update
    
    func test_update_item_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_update_item_without_bill() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_item_without_bill")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        let itemToEdit = BillItemResponse(id: item.id, name: "", value: 40000, status: .payed, installment: nil)
        
        XCTAssertThrowsError(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_update_item_without_existent_item() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_item_without_existent_item")
        let itemToEdit = BillItemResponse(id: UUID().uuidString, name: "", value: 40000, status: .payed, installment: nil)
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertThrowsError(try sut.updateBillItem(item: itemToEdit, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    // MARK: Delete
    
    func test_delete_item_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_delete_item_success")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertNoThrow(try sut.deleteItem(itemId: item.id, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_delete_item_without_bill() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_delete_item_without_bill")
        let item = annualCalendarMock.monthlyBills[0].sections[0].items[0]
        
        XCTAssertThrowsError(try sut.deleteItem(itemId: item.id, billId: annualCalendarMock.monthlyBills[0].id))
    }
    
    func test_delete_item_without_existent_item() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_delete_item_without_existent_item")
        try sut.create(annualCalendar: annualCalendarMock)
        
        XCTAssertThrowsError(try sut.deleteItem(itemId: UUID().uuidString, billId: annualCalendarMock.monthlyBills[0].id))
    }
}
