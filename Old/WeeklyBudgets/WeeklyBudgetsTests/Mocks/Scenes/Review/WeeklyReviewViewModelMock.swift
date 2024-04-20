//
//  WeeklyReviewViewModelMock.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 14/11/23.
//

@testable import WeeklyBudgets
import Foundation
import SharpnezCore

final class WeeklyReviewViewModelMock: WeeklyReviewViewModelProtocol {
    
    var presentAlert: Bool = false
    var alertMessage: String = ""
    var closeFlowAfterSubmit: Bool = false
    var weeks: [WeeklyBudgetViewModel]
    
    var presentError = false
    
    init(weeks: [WeeklyBudgetViewModel]) {
        self.weeks = weeks
    }
    
    func submit() throws {
        if presentError {
            closeFlowAfterSubmit = false
            throw CoreError.parseError
        } else {
            closeFlowAfterSubmit = true
        }
    }
}
