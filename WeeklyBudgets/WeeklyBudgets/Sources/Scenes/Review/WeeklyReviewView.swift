//
//  WeeklyReviewView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 02/09/23.
//

import SharpnezCore
import SwiftUI

struct WeeklyReviewView<ViewModel: WeeklyReviewViewModelProtocol>: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) private var flowPresented
    @StateObject private var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            WeekBudgetListView(weeks: $viewModel.weeks, deleteDisabled: true, detailDisabled: true, onUpdate: nil)
        }
        .navigationTitle(Constants.WeeklyReview.title)
        .toolbar {
            Button {
                submit()
            } label: {
                Text(Constants.Commons.create)
            }
        }
        .alert(Constants.Commons.AlertTitle, isPresented: $viewModel.presentAlert) {
            Button {
                alertDidTapped()
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
            try viewModel.submit()
            viewModel.alertMessage = Constants.WeeklyReview.successMessage
        } catch let error as CoreError {
            viewModel.alertMessage = error.message
        } catch {
            viewModel.alertMessage = Constants.Commons.defaultErrorMessage
        }
        viewModel.presentAlert = true
    }
    
    func alertDidTapped() {
        viewModel.presentAlert = false
        flowPresented.wrappedValue = !viewModel.closeFlowAfterSubmit
    }
}
