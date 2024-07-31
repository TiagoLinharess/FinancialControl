//
//  SingleWeekFormViewModelMock.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

@testable import WeeklyBudgets
import Foundation
import SharpnezCore

final class SingleWeekFormViewModelMock: AddBudgetViewModelProtocol {

    var presentAlert: Bool = false
    
    var alertMessage: String = String()
    
    var creditCardLimit: String = "$300.00"
    
    var weekSelected: String = "10/10/2023"
    
    var weekBudget: String = "$200.00"
    
    var weeks: [String] = ["12/12/2023", "11/11/2023", "10/10/2023"]
    
    var showError: Bool = false
    
    var error: CoreError?
    
    func submit() throws {
        if showError {
            error = CoreError.genericError
            throw CoreError.genericError
        }
    }
}
