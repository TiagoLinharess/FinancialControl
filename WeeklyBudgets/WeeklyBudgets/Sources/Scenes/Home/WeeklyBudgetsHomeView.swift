//
//  WeeklyBudgetsHomeView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Core
import SwiftUI

struct WeeklyBudgetsHomeView<ViewModel: WeeklyBudgetsHomeViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject var viewModel: ViewModel
    @Environment(\.weeklyDetailMode) private var weeklyDetailMode
    
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
                    WeekBudgetListView(weeks: $viewModel.budgets, onDelete: viewModel.delete, onUpdate: viewModel.fetchBudgets)
                case .empty:
                    HomeEmptyView()
                case let .error(message):
                    HomeErrorView(message: message, action: viewModel.fetchBudgets)
                }
            }
            .navigationTitle(CoreConstants.Commons.budgets)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(uiColor: .clear), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                Button {
                    viewModel.didTapAddBudget()
                } label: {
                    Label(String(), systemImage: CoreConstants.Icons.add)
                }
            }
            .onAppear {
                viewModel.fetchBudgets()
            }
            .sheet(isPresented: $viewModel.addBudgetFlowPresented) {
                viewModel.fetchBudgets()
            } content: {
                AddBudgetView(viewModel: AddBudgetFormViewModel())
                    .environment(\.weeklyModalMode, $viewModel.addBudgetFlowPresented)
            }
        }
    }
}
