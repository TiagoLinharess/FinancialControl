//
//  SingleWeekFormViewModelTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import XCTest

final class SingleWeekFormViewModelTests: XCTestCase {
    
    var sut: SingleWeekFormViewModel!
    
    override func setUpWithError() throws {
        sut = .init()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_date_values() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        
        XCTAssertTrue(sut.weeks[0] == "select")
        XCTAssertTrue(dateFormatter.date(from: sut.weeks[1]) != nil)
    }

    func test_submit_success() throws {
        sut.weekSelected = "12/12/2023"
        sut.weekBudget = "$200.00"
        sut.creditCardLimit = "$250.00"
        
        let model = try sut.submit()
        
        XCTAssertFalse(sut.presentAlert)
        XCTAssertTrue(model.week == "12/12/2023")
    }
    
    func test_submit_select_week_error() throws {
        sut.weekSelected = "select"
        sut.weekBudget = "$200.00"
        sut.creditCardLimit = "$250.00"
        
        do {
            let _ = try sut.submit()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Please, select a week to continue.")
        }
    }
    
    func test_submit_value_error() throws {
        sut.weekSelected = "10/10/2023"
        sut.weekBudget = "error"
        sut.creditCardLimit = "error"
        
        do {
            let _ = try sut.submit()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Please, fill all fields correctly to continue.")
        }
    }
    
    func test_submit_week_budget_error() throws {
        sut.weekSelected = "12/12/2023"
        sut.weekBudget = "error"
        sut.creditCardLimit = "error"
        
        do {
            let _ = try sut.submit()
        } catch {
            XCTAssertTrue((error as? CoreError)?.message == "Please, fill all fields correctly to continue.")
        }
    }
}
