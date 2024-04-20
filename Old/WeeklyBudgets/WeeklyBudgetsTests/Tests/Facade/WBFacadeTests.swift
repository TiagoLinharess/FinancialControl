//
//  WBFacadeTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 10/11/23.
//

@testable import WeeklyBudgets
import UIKit
import XCTest

final class WBFacadeTests: XCTestCase {

    func test_get_controller() throws {
        let sut = WBFacade()
        let controller = sut.start()
        
        XCTAssertTrue(controller is WeeklyBudgetsHomeHostingController)
    }
}
