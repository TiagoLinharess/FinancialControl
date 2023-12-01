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
        try sut.create(annualCalendar: .init(year: "2023", monthlyBills: [.init(month: "January", income: .init(salary: 0, bonus: 0, extra: 0, other: 0), investment: .init(shares: 0, privatePension: 0, fixedIncome: 0, other: 0), expense: .init(housing: 0, transport: 0, feed: 0, health: 0, education: 0, taxes: 0, laisure: 0, clothing: 0, creditCard: 0, other: 0))]))
        
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
}
