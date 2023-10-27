//
//  SingleWeekFormViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SharpnezDesignSystem
import SwiftUI

// MARK: View Status

enum SingleWeekFormViewStatus {
    case success(WeeklyBudgetViewModel), error(String), none
}

// MARK: Protocol

protocol SingleWeekFormViewModelProtocol: AnyObject, ObservableObject {
    var presentAlert: Bool { get set }
    var creditCardLimit: Double? { get set }
    var weekSelected: String { get set }
    var weekBudget: Double? { get set }
    var submitStatus: SingleWeekFormViewStatus { get set }
    var weeks: [String] { get }
    func submit()
}

// MARK: View Model

final class SingleWeekFormViewModel: SingleWeekFormViewModelProtocol {
    
    // MARK: Properties
    
    @Published var creditCardLimit: Double? = nil
    @Published var weekSelected: String = Constants.Commons.pickerSelect
    @Published var weekBudget: Double? = nil
    @Published var submitStatus: SingleWeekFormViewStatus = .none
    @Published var presentAlert: Bool = false
    
    var weeks: [String] {
        var weeksDate: [Date] = []
        
        for i in 0..<12 {
            guard let month = Calendar.current.date(byAdding: .month, value: i, to: Date()) else { break }
            weeksDate.append(contentsOf: month.firstWeekDayOfMonth(with: 1))
        }
        
        var weeks = weeksDate.map { date -> String in
            return date.localeFormat
        }
        
        weeks.insert(Constants.Commons.pickerSelect, at: .zero)
        
        return weeks
    }
    
    // MARK: Methods
    
    func submit() {
        presentAlert = false
        submitStatus = .none
        
        if weekSelected == Constants.Commons.pickerSelect {
            presentAlert = true
            submitStatus = .error(Constants.SingleWeekForm.selectWeekError)
            return
        }
        
        guard let weekBudget, let creditCardLimit else {
            presentAlert = true
            submitStatus = .error(Constants.SingleWeekForm.fillAllFieldsCorrectly)
            return
        }
        
        let weeklyBudget = WeeklyBudgetViewModel(
            week: weekSelected,
            originalBudget: weekBudget,
            creditCardWeekLimit: creditCardLimit
        )
        
        presentAlert = true
        submitStatus = .success(weeklyBudget)
    }
}
