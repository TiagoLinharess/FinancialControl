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
    @State private var currencyFormatter = Constants.Currency.formatter
    
    // MARK: Init
    
    init(viewModel: ViewModel, router: WeeklyDetailRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._router = StateObject(wrappedValue: router)
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            HStack {
                Picker(Constants.AddWeeklyExpenseView.paymentMode, selection: $viewModel.paymentMode) {
                    ForEach(viewModel.paymentModes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
            }
            HStack {
                Text(Constants.AddWeeklyExpenseView.title)
                TextField(Constants.AddWeeklyExpenseView.titlePlaceholder, text: $viewModel.title)
            }
            HStack {
                Text(Constants.AddWeeklyExpenseView.value)
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
            router.pop()
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
