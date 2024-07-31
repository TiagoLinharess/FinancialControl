//
//  WeeklyDetailRouterTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

@testable import WeeklyBudgets
import SwiftUI
import XCTest

final class WeeklyDetailRouterTests: XCTestCase {
    
    var sut: WeeklyDetailRouter!

    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_push() throws {
        sut.push(.addExpense(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in })))
        
        XCTAssertTrue(sut.path.count == 1)
    }
    
    func test_pop() throws {
        sut.push(.addExpense(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in })))
        sut.pop(1)
        
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    func test_get_destination_addExpense() throws {
        let view = sut.getDestination(from: .addExpense(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in })))
        
        XCTAssertTrue(view is _ConditionalContent<AddWeeklyExpenseView<AddWeeklyExpenseViewModel>, EditBudgetView<EditBudgetViewModel>>)
    }
    
    func test_get_destination_edit() throws {
        let view = sut.getDestination(from: .editBudget(Binding(get: { return WeeklyBudgetViewModelMock.getOne() }, set: { _,_ in })))
        
        XCTAssertTrue(view is _ConditionalContent<AddWeeklyExpenseView<AddWeeklyExpenseViewModel>, EditBudgetView<EditBudgetViewModel>>)
    }
}
