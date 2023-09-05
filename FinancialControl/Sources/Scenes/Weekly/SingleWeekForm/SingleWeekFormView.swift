//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Combine
import SwiftUI

struct SingleWeekFormView<ViewModel: SingleWeekFormViewModelProtocol>: View {
    
    // MARK: Field
    
    enum Field {
        case budget
        case creditCard
    }
    
    // MARK: Properties
    
    @FocusState private var focusedField: Field?
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
            Section {
                Picker(Constants.SingleWeekForm.pickerTitle, selection: $viewModel.weekSelected) {
                    ForEach(viewModel.weeks, id: \.self) {
                        if let firstElement = viewModel.weeks.first, $0 == firstElement {
                            Text($0)
                        } else {
                            Text(
                                String(format: Constants.SingleWeekForm.pickerSelection, $0)
                            )
                        }
                    }
                }
                .onChange(of: viewModel.weekSelected) { _ in
                    focusedField = .budget
                }
                VStack(alignment: .leading) {
                    TextField(Constants.SingleWeekForm.budgetPlaceholder, text: $viewModel.weekBudget)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .budget)
                        .submitLabel(.next)
                }
                VStack(alignment: .leading) {
                    TextField(Constants.SingleWeekForm.creditCardPlaceholder, text: $viewModel.creditCardLimit)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .creditCard)
                        .submitLabel(.join)
                }
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
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    switch focusedField {
                    case .budget:
                        focusedField = .creditCard
                    case .creditCard:
                        submit()
                    case .none:
                        break
                    }
                } label: {
                    Label(String(), systemImage: Constants.Icons.check)
                }
            }
        }
        .alert(Constants.Commons.AlertTitle, isPresented: $viewModel.presentAlert) {
            Button {
                alertDidTapped()
            } label: {
                Text(Constants.Commons.ok)
            }
        } message: {
            switch viewModel.submitStatus {
            case let .error(message):
                Text(message)
            default:
                Text(Constants.SingleWeekForm.formSuccessMessage)
            }
        }
    }
    
    // MARK: Methods
    
    func submit() {
        focusedField = .none
        viewModel.submit()
    }
    
    func alertDidTapped() {
        viewModel.presentAlert = false
        
        switch viewModel.submitStatus {
        case let .success(week):
            router.push(.review([week]))
        default:
            break
        }
    }
}
