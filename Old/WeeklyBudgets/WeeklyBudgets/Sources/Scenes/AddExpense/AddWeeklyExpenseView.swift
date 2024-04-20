//
//  AddWeeklyExpenseView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/10/23.
//

import Core
import CurrencyText
import SharpnezCore
import SwiftUI

struct AddWeeklyExpenseView<ViewModel: AddWeeklyExpenseViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject private var viewModel: ViewModel
    @StateObject private var router: WeeklyDetailRouter
    @State private var currencyFormatter = CurrencyFormatter.internationalDefault
    
    // MARK: Init
    
    init(viewModel: ViewModel, router: WeeklyDetailRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._router = StateObject(wrappedValue: router)
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            Section(Constants.AddWeeklyExpenseView.title) {
                TextField(Constants.AddWeeklyExpenseView.titlePlaceholder, text: $viewModel.title)
            }
            Section(Constants.AddWeeklyExpenseView.description) {
                TextField(Constants.AddWeeklyExpenseView.descriptionPlaceholder, text: $viewModel.description)
            }
            Section(Constants.AddWeeklyExpenseView.selectPaymentMode) {
                Picker(Constants.AddWeeklyExpenseView.paymentMode, selection: $viewModel.paymentMode) {
                    ForEach(viewModel.paymentModes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            Section(Constants.AddWeeklyExpenseView.value) {
                CurrencyTextField(configuration: .init(
                    placeholder: CoreConstants.Commons.currencyPlaceholder,
                    text: $viewModel.value,
                    formatter: $currencyFormatter,
                    textFieldConfiguration: nil
                ))
            }
        }
        .navigationTitle(Constants.WeeklyBudgetDetailView.addExpense)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                submit()
            } label: {
                Label(String(), systemImage: CoreConstants.Icons.check)
            }
        }
        .alert(CoreConstants.Commons.AlertTitle, isPresented: $viewModel.presentAlert) {
            Button {
                viewModel.alertAction?()
            } label: {
                Text(CoreConstants.Commons.ok)
            }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    // MARK: Methods
    
    func submit() {
        do {
            try viewModel.submit()
            viewModel.alertAction = {
                viewModel.presentAlert = false
                router.pop()
            }
            viewModel.alertMessage = Constants.AddWeeklyExpenseView.successMessage
            viewModel.presentAlert = true
        } catch {
            handleError(error: error)
        }
    }
    
    func handleError(error: Error) {
        if let error = error as? CoreError {
            viewModel.alertMessage = error.message
        } else {
            viewModel.alertMessage = error.localizedDescription
        }
        viewModel.alertAction = {
            viewModel.presentAlert = false
        }
        viewModel.presentAlert = true
    }
}
