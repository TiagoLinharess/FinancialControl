//
//  WeeklyBudgetsRepositoryTests.swift
//  ProviderTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import Provider
import XCTest
import SharpnezCore

final class WeeklyBudgetsRepositoryTests: XCTestCase {
    
    func test_key() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_key")
        XCTAssertTrue(sut.key == "WeeklyBudgetsRepository_test_key")
    }
    
    func test_key_nil() throws {
        let sut = WeeklyBudgetsRepository()
        XCTAssertTrue(sut.key == Constants.UserDefaultsKeys.weekly)
    }


    func test_create_success() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_create")
        try sut.create(weekBudgets: [])
        try sut.create(weekBudgets: [WeeklyResponseMock.getOne()])
        
        let response = try sut.read()
        XCTAssertTrue(response[0].id == WeeklyResponseMock.getOne().id)
    }
    
    func test_create_existent_week() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_create_existent_week")
        try sut.create(weekBudgets: [])
        try sut.create(weekBudgets: [WeeklyResponseMock.getOne()])
        
        do {
            try sut.create(weekBudgets: [WeeklyResponseMock.getOne()])
            throw CoreError.genericError
        } catch {
            guard let error = error as? CoreError else { throw CoreError.genericError }
            XCTAssertTrue(error.message == Constants.WeeklyBudgetsRepository.existentWeek)
        }
    }
    
    func test_read() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_read")
        try sut.create(weekBudgets: [])
        try sut.create(weekBudgets: [WeeklyResponseMock.getOne()])
        
        let response = try sut.read()
        XCTAssertTrue(response[0].id == WeeklyResponseMock.getOne().id)
    }
    
    func test_read_empty() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_read_empty")
        let response = try sut.read()
        XCTAssertTrue(response.isEmpty)
    }
    
    func test_update() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_update")
        try sut.create(weekBudgets: [])
        try sut.create(weekBudgets: [WeeklyResponseMock.getOne()])
        
        let responseToEdit = WeeklyBudgetResponse(
            id: "10/09/2023",
            week: "10/09/2023",
            originalBudget: 300,
            currentBudget: 54.27,
            creditCardWeekLimit: 200,
            creditCardRemainingLimit: 160.20,
            expenses: [.init(id: "AAAAALLLLLLLL", date: Date(), title: "iphone", description: String(), paymentMode: .credit, value: 1000)]
        )
        
        try sut.update(weekBudget: responseToEdit)
        let response = try sut.read()
        
        XCTAssertTrue(response[0].originalBudget == responseToEdit.originalBudget)
        XCTAssertTrue(response[0].expenses[0].title == "iphone")
    }
    
    func test_update_do_not_exist_week() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_update_do_not_exist_week")
        try sut.create(weekBudgets: [])
        
        let responseToEdit = WeeklyBudgetResponse(
            id: "10/09/2023",
            week: "10/09/2023",
            originalBudget: 300,
            currentBudget: 54.27,
            creditCardWeekLimit: 200,
            creditCardRemainingLimit: 160.20,
            expenses: []
        )
        
        do {
            try sut.update(weekBudget: responseToEdit)
            throw CoreError.genericError
        } catch {
            guard let error = error as? CoreError else { throw CoreError.genericError }
            XCTAssertTrue(error.message == Constants.WeeklyBudgetsRepository.weekDoesNotExist)
        }
    }
    
    func test_delete() throws {
        let sut = WeeklyBudgetsRepository(key: "WeeklyBudgetsRepository_test_delete")
        try sut.create(weekBudgets: [])
        try sut.create(weekBudgets: WeeklyResponseMock.getThree())
        
        let indexSet = IndexSet(integer: 0)
        let responseCount = try sut.delete(at: indexSet)
        
        XCTAssertTrue(responseCount == 2)
    }
}
