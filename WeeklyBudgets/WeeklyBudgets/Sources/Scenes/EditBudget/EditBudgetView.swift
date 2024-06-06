//
//  EditBudgetView.swift
//  WeeklyBudgets
//
//  Created by Tiago Linhares on 06/06/24.
//

import Core
import CurrencyText
import SharpnezCore
import SharpnezDesignSystem
import SwiftUI

struct EditBudgetView<ViewModel: EditBudgetViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject private var viewModel: ViewModel
    @StateObject private var router: WeeklyDetailRouter
    
    // MARK: Init
    
    init(viewModel: ViewModel, router: WeeklyDetailRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._router = StateObject(wrappedValue: router)
    }
    
    // MARK: Body
    
    var body: some View {
        WeekForm(
            weeks: viewModel.weeks,
            weekSelected: $viewModel.weekSelected,
            weekBudget: $viewModel.weekBudget,
            creditCardLimit: $viewModel.creditCardLimit
        )
        .navigationTitle(Constants.WeekBudgetView.budgetTitle)
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
                viewModel.presentAlert = false
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
        viewModel.presentAlert = true
    }
}
