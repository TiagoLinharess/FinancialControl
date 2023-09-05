//
//  WeeklyReviewView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 02/09/23.
//

import SwiftUI

struct WeeklyReviewView<ViewModel: WeeklyReviewViewModelProtocol>: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) private var flowPresented
    @StateObject private var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            WeekBudgetListView(weeks: viewModel.weeks)
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
            Text(Constants.WeeklyReview.successMessage)
        }
    }
    
    func submit() {
        viewModel.submit()
    }
    
    func alertDidTapped() {
        viewModel.presentAlert = false
        flowPresented.wrappedValue = false
    }
}
