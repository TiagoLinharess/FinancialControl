//
//  AddBudgetView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Core
import CurrencyText
import SharpnezCore
import SharpnezDesignSystem
import SwiftUI

struct AddBudgetView<ViewModel: AddBudgetViewModelProtocol>: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) private var flowPresented
    @StateObject private var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            WeekForm(
                weeks: viewModel.weeks,
                weekSelected: $viewModel.weekSelected,
                weekBudget: $viewModel.weekBudget,
                creditCardLimit: $viewModel.creditCardLimit
            )
            .navigationTitle(Constants.SingleWeekForm.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        close()
                    } label: {
                        Label(String(), systemImage: CoreConstants.Icons.close)
                    }
                }
            }
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
    
    func close() {
        flowPresented.wrappedValue.toggle()
    }
    
    func submit() {
        do {
            try viewModel.submit()
            close()
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
