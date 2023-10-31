//
//  AddWeeklyExpenseViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/10/23.
//

import SharpnezCore
import SwiftUI

// MARK: Protocol

protocol AddWeeklyExpenseViewModelProtocol: ObservableObject {
    var weekBudget: WeeklyBudgetViewModel { get set }
    var title: String { get set }
    var description: String { get set }
    var paymentMode: String { get set }
    var value: Double? { get set }
    var paymentModes: [String] { get }
    var presentAlert: Bool { get set }
    var alertMessage: String { get set }
    func submit() throws -> WeeklyExpenseViewModel
}

// MARK: View Model

final class AddWeeklyExpenseViewModel: AddWeeklyExpenseViewModelProtocol {

    // MARK: Properties
    
    @Binding var weekBudget: WeeklyBudgetViewModel
    @Published var title: String = String()
    @Published var description: String = String()
    @Published var paymentMode: String = Constants.Commons.pickerSelect
    @Published var value: Double?
    @Published var presentAlert: Bool = false
    @Published var alertMessage: String = String()
    
    var paymentModes: [String] {
        var options = [Constants.Commons.pickerSelect]
        options.append(contentsOf: PaymentMode.allCases.map { return $0.rawValue })
        return options
    }
    
    // MARK: Init
    
    init(weekBudget: Binding<WeeklyBudgetViewModel>) {
        self._weekBudget = weekBudget
    }
    
    // MARK: Methods
    
    func submit() throws -> WeeklyExpenseViewModel {
        guard let value,
              value > 0,
              let paymentMode = PaymentMode(rawValue: paymentMode),
              !title.isEmpty
        else {
            throw CoreError.customError(Constants.SingleWeekForm.fillAllFieldsCorrectly)
        }
        
        return WeeklyExpenseViewModel(
            title: title,
            description: description,
            paymentMode: paymentMode,
            value: value
        )
    }
}
