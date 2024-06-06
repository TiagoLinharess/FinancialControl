//
//  EditBudgetViewModel.swift
//  WeeklyBudgets
//
//  Created by Tiago Linhares on 06/06/24.
//

import Combine
import Core
import SharpnezCore
import SwiftUI

protocol EditBudgetViewModelProtocol: AnyObject, ObservableObject {
    var presentAlert: Bool { get set }
    var alertMessage: String { get set }
    var creditCardLimit: String { get set }
    var weekSelected: String { get set }
    var weekBudget: String { get set }
    var weeks: [String] { get }
    func submit() throws
}

final class EditBudgetViewModel: EditBudgetViewModelProtocol {
    
    // MARK: Properties
    
    @Binding var budget: WeeklyBudgetViewModel
    @Published var creditCardLimit: String = String()
    @Published var weekSelected: String = String()
    @Published var weekBudget: String = String()
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = String()
    
    private let worker: WeeklyWorkerProtocol
    
    var weeks: [String] {
        var weeksDate: [Date] = []
        
        for i in 0..<12 {
            guard let month = Calendar.current.date(byAdding: .month, value: i, to: Date()) else { break }
            weeksDate.append(contentsOf: month.firstWeekDayOfMonth(with: 1))
        }
        
        var weeks = weeksDate.map { date -> String in
            return date.localeFormat
        }
        
        weeks.insert(
            weeks.contains(budget.week) ? CoreConstants.Commons.pickerSelect : budget.week,
            at: .zero
        )
        
        return weeks
    }
    
    // MARK: Init
    
    init(budget: Binding<WeeklyBudgetViewModel>, worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self._budget = budget
        self.worker = worker
        setup()
    }
    
    // MARK: Methods
    
    func setup() {
        weekBudget = budget.originalBudget.toCurrency()
        creditCardLimit = budget.creditCardWeekLimit.toCurrency()
        weekSelected = budget.week
    }
    
    func submit() throws {
        guard let weekBudget = weekBudget.currencyToDouble, let creditCardLimit = creditCardLimit.currencyToDouble else {
            throw CoreError.customError(Constants.SingleWeekForm.fillAllFieldsCorrectly)
        }
        
        var viewModel = WeeklyBudgetViewModel(
            id: budget.id,
            week: weekSelected,
            originalBudget: weekBudget,
            currentBudget: weekBudget,
            creditCardWeekLimit: creditCardLimit,
            creditCardRemainingLimit: creditCardLimit
        )
        
        budget.expenses.forEach { expense in
            viewModel.addExpense(expense: expense)
        }
        
        try worker.update(weekBudget: viewModel)
        budget = viewModel
    }
}
