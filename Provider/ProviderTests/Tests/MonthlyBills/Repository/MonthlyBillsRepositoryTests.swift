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
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_existent_week")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_empty")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_error")
    }

    func test_key() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_key")
        XCTAssertTrue(sut.key == "MonthlyBillsRepository_test_key")
    }
    
    func test_key_nil() throws {
        let sut = MonthlyBillsRepository()
        XCTAssertTrue(sut.key == Constants.UserDefaultsKeys.bills)
    }


    func test_create_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", income: .init(id: UUID().uuidString, salary: 0, bonus: 0, extra: 0, other: 0), investment: .init(id: UUID().uuidString, shares: 0, privatePension: 0, fixedIncome: 0, other: 0), expense: .init(id: UUID().uuidString, housing: 0, transport: 0, feed: 0, health: 0, education: 0, taxes: 0, laisure: 0, clothing: 0, creditCard: 0, other: 0))]))
        
        let response = try sut.read()
        XCTAssertTrue(response[0].year == "2023")
    }
    
    func test_create_existent_week() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_create_existent_week")
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
        
        do {
            try sut.create(annualCalendar: .init(year: "2023", monthlyBills: []))
            throw CoreError.genericError
        } catch {
            guard let error = error as? CoreError else { throw CoreError.genericError }
            XCTAssertTrue(error.message == Constants.MonthlyBillsRepository.existentCalendar)
        }
    }
    
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
        
        do {
            let _ = try sut.readAtYear(year: "2023")
            throw CoreError.genericError
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Could not find calendar")
        }
    }
    
    func test_read_at_month_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_month_success")
        let calendar = AnnualCalendarResponse(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", income: nil, investment: nil, expense: nil)])
        try sut.create(annualCalendar: calendar)
        let matchingBill = try sut.readAtMonth(id: calendar.monthlyBills[0].id)
        
        XCTAssertTrue(matchingBill.id == calendar.monthlyBills[0].id)
    }
    
    func test_read_at_month_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_read_at_month_error")
        
        do {
            let _ = try sut.readAtMonth(id: UUID().uuidString)
            throw CoreError.genericError
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Could not find bill")
        }
    }
}
