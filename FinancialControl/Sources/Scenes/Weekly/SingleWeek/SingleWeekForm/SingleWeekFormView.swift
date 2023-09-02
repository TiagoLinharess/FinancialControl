//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct SingleWeekFormView<ViewModel: SingleWeekFormViewModelProtocol>: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) var flowPresented
    @StateObject var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            Section {
                Picker("Select a week", selection: $viewModel.weekSelected) {
                    ForEach(viewModel.weeks, id: \.self) {
                        Text("week of \($0)")
                    }
                }
                VStack(alignment: .leading) {
                    Text("Week Budget")
                    TextField("Enter week budget", text: $viewModel.weekBudget)
                        .keyboardType(.decimalPad)
                }
                VStack(alignment: .leading) {
                    Text("Credit card week limit")
                    TextField("Enter credit card week limit", text: $viewModel.creditCardLimit)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(Constants.SingleWeekForm.title)
        }
        Button {
            viewModel.submit()
        } label: {
            Label("submit", systemImage: "checkmark")
        }
    }
}
