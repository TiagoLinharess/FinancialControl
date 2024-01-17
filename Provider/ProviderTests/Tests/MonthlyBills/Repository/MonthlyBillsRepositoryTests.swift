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
    
    let annualCalendarMock: AnnualCalendarResponse = .init(year: "2023", monthlyBills: [.init(id: UUID().uuidString, month: "January", income: .init(salary: 0, bonus: 0, extra: 0, other: 0), investment: .init(shares: 0, privatePension: 0, fixedIncome: 0, other: 0), expense: .init(housing: 0, transport: 0, feed: 0, health: 0, education: 0, taxes: 0, laisure: 0, clothing: 0, creditCard: 0, other: 0))])
    
    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_create_existent_week")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_empty")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_year_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_read_at_month_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_income_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_income_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_investment_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_investment_error")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_expense_success")
        UserDefaults.standard.removeObject(forKey: "MonthlyBillsRepository_test_update_expense_error")
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
        try sut.create(annualCalendar: annualCalendarMock)
        
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
    
    func test_update_income_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_income_success")
        try sut.create(annualCalendar: annualCalendarMock)
        
        guard let firstMonthlyBill = annualCalendarMock.monthlyBills.first else {
            throw CoreError.genericError
        }
        
        let newIncome = IncomeResponse(salary: 200, bonus: 126, extra: 234, other: 987)
        try sut.updateIncome(response: newIncome, billId: firstMonthlyBill.id)
        let updatedMonth = try sut.readAtMonth(id: firstMonthlyBill.id)
        
        XCTAssertEqual(updatedMonth.income?.salary, newIncome.salary)
        XCTAssertEqual(updatedMonth.income?.bonus, newIncome.bonus)
        XCTAssertEqual(updatedMonth.income?.extra, newIncome.extra)
        XCTAssertEqual(updatedMonth.income?.other, newIncome.other)
    }
    
    func test_update_income_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_income_error")
        try sut.create(annualCalendar: annualCalendarMock)
        let newIncome = IncomeResponse(salary: 200, bonus: 126, extra: 234, other: 987)
        
        do {
            try sut.updateIncome(response: newIncome, billId: UUID().uuidString)
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Could not find bill")
        }
    }
    
    func test_update_investment_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_investment_success")
        try sut.create(annualCalendar: annualCalendarMock)
        
        guard let firstMonthlyBill = annualCalendarMock.monthlyBills.first else {
            throw CoreError.genericError
        }
        
        let newInvestment = InvestmentResponse(shares: 200, privatePension: 200, fixedIncome: 200, other: 200)
        try sut.updateInvestment(response: newInvestment, billId: firstMonthlyBill.id)
        let updatedMonth = try sut.readAtMonth(id: firstMonthlyBill.id)
        
        XCTAssertEqual(updatedMonth.investment?.shares, newInvestment.shares)
        XCTAssertEqual(updatedMonth.investment?.fixedIncome, newInvestment.fixedIncome)
        XCTAssertEqual(updatedMonth.investment?.privatePension, newInvestment.privatePension)
        XCTAssertEqual(updatedMonth.investment?.other, newInvestment.other)
    }
    
    func test_update_investment_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_investment_error")
        try sut.create(annualCalendar: annualCalendarMock)
        let newInvestment = InvestmentResponse(shares: 200, privatePension: 200, fixedIncome: 200, other: 200)
        
        do {
            try sut.updateInvestment(response: newInvestment, billId: UUID().uuidString)
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Could not find bill")
        }
    }
    
    func test_update_expense_success() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_expense_success")
        try sut.create(annualCalendar: annualCalendarMock)
        
        guard let firstMonthlyBill = annualCalendarMock.monthlyBills.first else {
            throw CoreError.genericError
        }
        
        let newExpense = ExpenseResponse(housing: 200, transport: 200200, feed: 200, health: 200, education: 200, taxes: 200, laisure: 200, clothing: 200, creditCard: 200, other: 200)
        try sut.updateExpense(response: newExpense, billId: firstMonthlyBill.id)
        let updatedMonth = try sut.readAtMonth(id: firstMonthlyBill.id)
        
        XCTAssertEqual(updatedMonth.expense?.housing, newExpense.housing)
        XCTAssertEqual(updatedMonth.expense?.transport, newExpense.transport)
        XCTAssertEqual(updatedMonth.expense?.feed, newExpense.feed)
        XCTAssertEqual(updatedMonth.expense?.health, newExpense.health)
        XCTAssertEqual(updatedMonth.expense?.education, newExpense.education)
        XCTAssertEqual(updatedMonth.expense?.taxes, newExpense.taxes)
        XCTAssertEqual(updatedMonth.expense?.laisure, newExpense.laisure)
        XCTAssertEqual(updatedMonth.expense?.clothing, newExpense.clothing)
        XCTAssertEqual(updatedMonth.expense?.creditCard, newExpense.creditCard)
        XCTAssertEqual(updatedMonth.expense?.other, newExpense.other)
    }
    
    func test_update_expense_error() throws {
        let sut = MonthlyBillsRepository(key: "MonthlyBillsRepository_test_update_expense_error")
        try sut.create(annualCalendar: annualCalendarMock)
        let newExpense = ExpenseResponse(housing: 200, transport: 200200, feed: 200, health: 200, education: 200, taxes: 200, laisure: 200, clothing: 200, creditCard: 200, other: 200)
        
        do {
            try sut.updateExpense(response: newExpense, billId: UUID().uuidString)
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Could not find bill")
        }
    }
}
