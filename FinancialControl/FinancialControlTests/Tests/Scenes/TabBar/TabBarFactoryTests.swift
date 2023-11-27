//
//  TabBarFactoryTests.swift
//  FinancialControlTests
//
//  Created by Tiago Linhares on 13/11/23.
//

@testable import FinancialControl
import SwiftUI
import XCTest

final class TabBarFactoryTests: XCTestCase {

    func test_controllers_count() throws {
        let sut = TabBarFactory.configure()
        XCTAssertTrue(sut.viewControllers?.count == 2)
    }
}
