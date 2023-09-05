//
//  SingleWeekFormViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 31/08/23.
//

import SharpnezDesignSystem
import SwiftUI

enum SingleWeekFormViewStatus {
    case success(WeeklyBudgetViewModel), error(String), none
}

protocol SingleWeekFormViewModelProtocol: AnyObject, ObservableObject {
    var presentAlert: Bool { get set }
    var creditCardLimit: String { get set }
    var weekSelected: String { get set }
    var weekBudget: String { get set }
    var submitStatus: SingleWeekFormViewStatus { get set }
    var weeks: [String] { get }
    func submit()
}

final class SingleWeekFormViewModel: SingleWeekFormViewModelProtocol {
    
    @Published var creditCardLimit: String = String()
    @Published var weekSelected: String = Constants.Commons.pickerSelect
    @Published var weekBudget: String = String()
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
    
    func submit() {
        presentAlert = false
        submitStatus = .none
        
        if weekSelected == Constants.Commons.pickerSelect {
            presentAlert = true
            submitStatus = .error(Constants.SingleWeekForm.selectWeekError)
            return
        }
        
        if weekBudget.isEmpty || creditCardLimit.isEmpty {
            presentAlert = true
            submitStatus = .error(Constants.SingleWeekForm.fillAllFieldsError)
            return
        }
        
        guard let doubleWeekBudget = Double(weekBudget),
              let doubleCreditCardLimit = Double(creditCardLimit)
        else {
            presentAlert = true
            submitStatus = .error(Constants.SingleWeekForm.fillAllFieldsCorrectly)
            return
        }
        
        let weekBudget = WeeklyBudgetViewModel(
            week: weekSelected,
            originalBudget: doubleWeekBudget,
            creditCardWeekLimit: doubleCreditCardLimit
        )
        
        presentAlert = true
        submitStatus = .success(weekBudget)
    }
}
