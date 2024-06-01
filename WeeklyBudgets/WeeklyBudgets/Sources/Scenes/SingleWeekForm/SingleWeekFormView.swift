//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Core
import CurrencyText
import SharpnezCore
import SharpnezDesignSystem
import SwiftUI

struct SingleWeekFormView<ViewModel: SingleWeekFormViewModelProtocol>: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) private var flowPresented
    @StateObject private var viewModel: ViewModel
    @State private var currencyFormatter = CurrencyFormatter.internationalDefault
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(Constants.SingleWeekForm.pickerTitle)) {
                    Picker(Constants.WeekBudgetView.weekTitle, selection: $viewModel.weekSelected) {
                        ForEach(viewModel.weeks, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: CoreConstants.Sizes.pickerHeight)
                }
                Section(header: Text(Constants.SingleWeekForm.budgetPlaceholder)) {
                    CurrencyTextField(configuration: .init(
                        placeholder: CoreConstants.Commons.currencyPlaceholder,
                        text: $viewModel.weekBudget,
                        formatter: $currencyFormatter,
                        textFieldConfiguration: nil
                    ))
                }
                Section(header: Text(Constants.SingleWeekForm.creditCardPlaceholder)) {
                    CurrencyTextField(configuration: .init(
                        placeholder: CoreConstants.Commons.currencyPlaceholder,
                        text: $viewModel.creditCardLimit,
                        formatter: $currencyFormatter,
                        textFieldConfiguration: nil
                    ))
                }
            }
            .navigationTitle(Constants.SingleWeekForm.title)
            .toolbar {
                Button {
                    submit()
                } label: {
                    Label(String(), systemImage: CoreConstants.Icons.check)
                }
            }
            .alert(CoreConstants.Commons.AlertTitle, isPresented: $viewModel.presentAlert) {
                Button {
                    viewModel.presentAlert = false
                } label: {
                    Text(CoreConstants.Commons.ok)
                }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
    
    // MARK: Methods
    
    func submit() {
        do {
            try viewModel.submit()
            flowPresented.wrappedValue.toggle()
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
