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
    @Published var creditCardLimit: String = ""
    @Published var weekSelected: String = ""
    @Published var weekBudget: String = ""
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private let worker: WeeklyWorkerProtocol
    private var cachedWeeks: [String]?
    
    var weeks: [String] {
        if let cachedWeeks = cachedWeeks {
            return cachedWeeks
        }
        let generatedWeeks = generateWeeks()
        cachedWeeks = generatedWeeks
        return generatedWeeks
    }
    
    // MARK: Init
    
    init(budget: Binding<WeeklyBudgetViewModel>, worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self._budget = budget
        self.worker = worker
        setup()
    }
    
    // MARK: Methods
    
    private func setup() {
        weekBudget = budget.originalBudget.toCurrency()
        creditCardLimit = budget.creditCardWeekLimit.toCurrency()
        weekSelected = budget.week
    }
    
    private func generateWeeks() -> [String] {
        var weeksDate: [Date] = []
        
        for i in 0..<12 {
            if let month = Calendar.current.date(byAdding: .month, value: i, to: Date()) {
                weeksDate.append(contentsOf: month.firstWeekDayOfMonth(with: 1))
            }
        }
        
        var weeks = weeksDate.map { $0.localeFormat }
        
        if !weeks.contains(budget.week) {
            weeks.insert(budget.week, at: 0)
        } else {
            weeks.insert(CoreConstants.Commons.pickerSelect, at: 0)
        }
        
        return weeks
    }
    
    func submit() throws {
        guard let weekBudgetValue = weekBudget.currencyToDouble, let creditCardLimitValue = creditCardLimit.currencyToDouble else {
            throw CoreError.customError(Constants.SingleWeekForm.fillAllFieldsCorrectly)
        }
        
        var updatedBudget = WeeklyBudgetViewModel(
            id: budget.id,
            week: weekSelected,
            originalBudget: weekBudgetValue,
            currentBudget: weekBudgetValue,
            creditCardWeekLimit: creditCardLimitValue,
            creditCardRemainingLimit: creditCardLimitValue
        )
        
        budget.expenses.forEach { updatedBudget.addExpense(expense: $0) }
        
        try worker.update(weekBudget: updatedBudget)
        budget = updatedBudget
    }
}
