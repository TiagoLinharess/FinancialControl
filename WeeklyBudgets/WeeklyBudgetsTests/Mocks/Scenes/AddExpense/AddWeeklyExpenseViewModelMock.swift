//
//  AddWeeklyExpenseViewModelMock.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 19/11/23.
//

@testable import WeeklyBudgets
import Foundation
import SharpnezCore

final class AddWeeklyExpenseViewModelMock: AddWeeklyExpenseViewModelProtocol {

    var weekBudget: WeeklyBudgets.WeeklyBudgetViewModel = WeeklyBudgetViewModelMock.getOne()
    
    var title: String = "iphone"
    
    var description: String = "iphone 15"
    
    var paymentMode: String = "credit"
    
    var value: String = "$222.99"
    
    var paymentModes: [String] = ["credit", "debit"]
    
    var presentAlert: Bool = false
    
    var alertMessage: String = String()
    
    var alertAction: (() -> Void)? = nil
    
    var isError: Bool = false
    
    func submit() throws {
        if isError {
            throw CoreError.genericError
        }
    }
}
