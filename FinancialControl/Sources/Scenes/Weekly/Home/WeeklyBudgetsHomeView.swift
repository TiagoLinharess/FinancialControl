//
//  WeeklyBudgetsHomeView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct WeeklyBudgetsHomeView<ViewModel: WeeklyBudgetsHomeViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: .small) {
                switch viewModel.viewStatus {
                case .success:
                    WeekBudgetListView(weeks: viewModel.budgets, deleteDisabled: false, onDelete: viewModel.delete)
                case .empty:
                    HomeEmptyView()
                case let .error(message):
                    HomeErrorView(message: message, action: viewModel.fetchBudgets)
                }
            }
            .navigationTitle(Constants.WeeklyHome.title)
            .onAppear {
                viewModel.fetchBudgets()
            }
            .toolbar {
                Button {
                    viewModel.didTapAddBudget()
                } label: {
                    Label(String(), systemImage: Constants.Icons.add)
                }
            }
            .sheet(isPresented: $viewModel.addBudgetFlowPresented) {
                viewModel.fetchBudgets()
            } content: {
                AddWeeklyBudgetStartView()
                    .environment(\.weeklyModalMode, $viewModel.addBudgetFlowPresented)
            }
        }
    }
}
