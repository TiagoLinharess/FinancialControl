//
//  SingleWeekFormViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import Core
import SharpnezCore
import SharpnezDesignSystem
import SwiftUI

// MARK: Protocol

protocol SingleWeekFormViewModelProtocol: AnyObject, ObservableObject {
    var presentAlert: Bool { get set }
    var alertMessage: String { get set }
    var creditCardLimit: String { get set }
    var weekSelected: String { get set }
    var weekBudget: String { get set }
    var weeks: [String] { get }
    func submit() throws -> WeeklyBudgetViewModel
}

// MARK: View Model

final class SingleWeekFormViewModel: SingleWeekFormViewModelProtocol {
    
    // MARK: Properties
    
    @Published var creditCardLimit: String = String()
    @Published var weekSelected: String = CoreConstants.Commons.pickerSelect
    @Published var weekBudget: String = String()
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = String()
    
    var weeks: [String] {
        var weeksDate: [Date] = []
        
        for i in 0..<12 {
            guard let month = Calendar.current.date(byAdding: .month, value: i, to: Date()) else { break }
            weeksDate.append(contentsOf: month.firstWeekDayOfMonth(with: 1))
        }
        
        var weeks = weeksDate.map { date -> String in
            return date.localeFormat
        }
        
        weeks.insert(CoreConstants.Commons.pickerSelect, at: .zero)
        
        return weeks
    }
    
    // MARK: Methods
    
    func submit() throws -> WeeklyBudgetViewModel {
        if weekSelected == CoreConstants.Commons.pickerSelect {
            throw CoreError.customError(Constants.SingleWeekForm.selectWeekError)
        }
        
        guard let weekBudget = weekBudget.currencyToDouble, let creditCardLimit = creditCardLimit.currencyToDouble else {
            throw CoreError.customError(Constants.SingleWeekForm.fillAllFieldsCorrectly)
        }
        
        return WeeklyBudgetViewModel(
            week: weekSelected,
            originalBudget: weekBudget,
            creditCardWeekLimit: creditCardLimit
        )
    }
}
