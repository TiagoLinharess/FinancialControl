//
//  WeeklyReviewViewTests.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 14/11/23.
//

@testable import WeeklyBudgets
import SharpnezCore
import SnapshotTesting
import SwiftUI
import XCTest

final class WeeklyReviewViewTests: XCTestCase {

    func test_snapshot() throws {
        let sut = WeeklyReviewView(viewModel: WeeklyReviewViewModel(weeks: [WeeklyBudgetViewModelMock.getOne()]))
        let vc = UIHostingController(rootView: sut)
        vc.view.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_alert_did_tapped() throws {
        let viewModelMock = WeeklyReviewViewModelMock(weeks: [WeeklyBudgetViewModelMock.getOne()])
        let sut = WeeklyReviewView(viewModel: viewModelMock)
        
        sut.alertDidTapped()
        
        XCTAssertTrue(viewModelMock.presentAlert == false)
    }
    
    func test_submit_success() throws {
        let viewModelMock = WeeklyReviewViewModelMock(weeks: [WeeklyBudgetViewModelMock.getOne()])
        let sut = WeeklyReviewView(viewModel: viewModelMock)
        
        viewModelMock.presentError = false
        sut.submit()
        
        XCTAssertTrue(viewModelMock.alertMessage == "Budgets added with success")
        XCTAssertTrue(viewModelMock.closeFlowAfterSubmit == true)
    }
    
    func test_submit_error() throws {
        let viewModelMock = WeeklyReviewViewModelMock(weeks: [WeeklyBudgetViewModelMock.getOne()])
        let sut = WeeklyReviewView(viewModel: viewModelMock)
        
        viewModelMock.presentError = true
        sut.submit()
        
        XCTAssertTrue(viewModelMock.alertMessage == CoreError.parseError.message)
        XCTAssertTrue(viewModelMock.closeFlowAfterSubmit == false)
    }
}
