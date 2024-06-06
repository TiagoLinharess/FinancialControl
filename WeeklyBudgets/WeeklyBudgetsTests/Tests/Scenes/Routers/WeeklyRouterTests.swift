//
//  WeeklyRouterTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 23/11/23.
//

@testable import WeeklyBudgets
import SwiftUI
import XCTest

final class WeeklyRouterTests: XCTestCase {

    var sut: WeeklyRouter!

    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_push() throws {
        sut.push(.singleWeekForm)
        
        XCTAssertTrue(sut.path.count == 1)
    }
    
    func test_pop() throws {
        sut.push(.singleWeekForm)
        sut.pop(1)
        
        XCTAssertTrue(sut.path.isEmpty)
    }
    
    func test_get_destination_singleWeekForm() throws {
        let view = sut.getDestination(from: .singleWeekForm)
        
        XCTAssertTrue(view is _ConditionalContent<AddWeekFormView<AddWeekFormViewModel>, WeeklyReviewView<WeeklyReviewViewModel>>)
    }
    
    func test_get_destination_review() throws {
        let view = sut.getDestination(from: .review([]))
        
        XCTAssertTrue(view is _ConditionalContent<AddWeekFormView<AddWeekFormViewModel>, WeeklyReviewView<WeeklyReviewViewModel>>)
    }
}
