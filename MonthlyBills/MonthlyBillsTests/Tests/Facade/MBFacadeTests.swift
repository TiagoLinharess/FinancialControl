//
//  MBFacadeTests.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 15/02/24.
//

@testable import MonthlyBills
import XCTest

final class MBFacadeTests: XCTestCase {

    func test_get_controller() throws {
        let sut = MBFacade()
        let controller = sut.start()
        
        XCTAssertTrue(controller is HomeViewController)
    }
}
