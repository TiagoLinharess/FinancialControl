//
//  AddWeeklyExpenseViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/10/23.
//

import Core
import SharpnezCore
import SwiftUI

// MARK: Protocol

protocol AddWeeklyExpenseViewModelProtocol: ObservableObject {
    var weekBudget: WeeklyBudgetViewModel { get set }
    var title: String { get set }
    var paymentMode: String { get set }
    var value: String { get set }
    var paymentModes: [String] { get }
    var presentAlert: Bool { get set }
    var alertMessage: String { get set }
    var alertAction: (() -> Void)? { get set }
    func submit() throws
}

// MARK: View Model

final class AddWeeklyExpenseViewModel: AddWeeklyExpenseViewModelProtocol {

    // MARK: Properties
    
    @Binding var weekBudget: WeeklyBudgetViewModel
    @Published var title: String = String()
    @Published var paymentMode: String = CoreConstants.Commons.pickerSelect
    @Published var value: String = String()
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = String()
    var alertAction: (() -> Void)?
    
    var paymentModes: [String] {
        var options = [CoreConstants.Commons.pickerSelect]
        options.append(contentsOf: PaymentMode.allCases.map { return $0.rawValue })
        return options
    }
    
    private let worker: WeeklyWorkerProtocol
    
    // MARK: Init
    
    init(weekBudget: Binding<WeeklyBudgetViewModel>, worker: WeeklyWorkerProtocol = WeeklyWorker()) {
        self._weekBudget = weekBudget
        self.worker = worker
    }
    
    // MARK: Methods
    
    func submit() throws {
        guard let value = value.currencyToDouble,
              value > 0,
              let paymentMode = PaymentMode(rawValue: paymentMode),
              !title.isEmpty
        else {
            throw CoreError.customError(Constants.SingleWeekForm.fillAllFieldsCorrectly)
        }
        
        let expense = WeeklyExpenseViewModel(
            title: title,
            paymentMode: paymentMode,
            value: value
        )
        
        let newWeekBudget = weekBudget
        newWeekBudget.addExpense(expense: expense)
        
        do {
            try worker.update(weekBudget: newWeekBudget)
            weekBudget = newWeekBudget
        } catch {
            throw error
        }
    }
}
