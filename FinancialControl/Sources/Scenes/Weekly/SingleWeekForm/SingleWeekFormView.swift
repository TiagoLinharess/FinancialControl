//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Combine
import SharpnezCore
import SharpnezDesignSystem
import SwiftUI

struct SingleWeekFormView<ViewModel: SingleWeekFormViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject private var viewModel: ViewModel
    @StateObject private var router: WeeklyRouter
    
    // MARK: Init
    
    init(viewModel: ViewModel, router: WeeklyRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._router = StateObject(wrappedValue: router)
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            Section(header: Text(Constants.SingleWeekForm.pickerTitle)) {
                Picker(Constants.WeekBudgetView.weekTitle, selection: $viewModel.weekSelected) {
                    ForEach(viewModel.weeks, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            Section(header: Text(Constants.SingleWeekForm.budgetPlaceholder)) {
                CurrencyTextField(Constants.Commons.currencyPlaceholder, value: $viewModel.weekBudget)
            }
            Section(header: Text(Constants.SingleWeekForm.creditCardPlaceholder)) {
                CurrencyTextField(Constants.Commons.currencyPlaceholder, value: $viewModel.creditCardLimit)
            }
        }
        .navigationTitle(Constants.SingleWeekForm.title)
        .toolbar {
            Button {
                submit()
            } label: {
                Label(String(), systemImage: Constants.Icons.check)
            }
        }
        .alert(Constants.Commons.AlertTitle, isPresented: $viewModel.presentAlert) {
            Button {
                viewModel.presentAlert = false
            } label: {
                Text(Constants.Commons.ok)
            }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    // MARK: Methods
    
    func submit() {
        do {
            let budget = try viewModel.submit()
            router.push(.review([budget]))
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
        viewModel.presentAlert = true
    }
}
