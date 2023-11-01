//
//  BudgetDetailView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 29/10/23.
//

import SwiftUI

struct WeeklyBudgetDetailView<ViewModel: WeeklyBudgetDetailViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject var viewModel: ViewModel
    @StateObject private var router = WeeklyDetailRouter()
    @Environment(\.weeklyDetailMode) private var weeklyDetailMode
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                Section(Constants.WeekBudgetView.budgetTitle) {
                    HStack {
                        Text(Constants.WeeklyBudgetDetailView.original)
                        Spacer()
                        Text(viewModel.weekBudget.originalBudget.toCurrency())
                            .foregroundColor(Color.budgetColor(total: viewModel.weekBudget.originalBudget, current: viewModel.weekBudget.originalBudget))
                    }
                    HStack {
                        Text(Constants.WeeklyBudgetDetailView.current)
                        Spacer()
                        Text(viewModel.weekBudget.currentBudget.toCurrency())
                            .foregroundColor(Color.budgetColor(total: viewModel.weekBudget.originalBudget, current: viewModel.weekBudget.currentBudget))
                    }
                }
                Section(Constants.WeekBudgetView.creditCardTitle) {
                    HStack {
                        Text(Constants.WeeklyBudgetDetailView.limit)
                        Spacer()
                        Text(viewModel.weekBudget.creditCardWeekLimit.toCurrency())
                            .foregroundColor(Color.budgetColor(total: viewModel.weekBudget.creditCardWeekLimit, current: viewModel.weekBudget.creditCardWeekLimit))
                    }
                    HStack {
                        Text(Constants.WeeklyBudgetDetailView.remainingLimit)
                        Spacer()
                        Text(viewModel.weekBudget.creditCardRemainingLimit.toCurrency())
                            .foregroundColor(Color.budgetColor(total: viewModel.weekBudget.creditCardWeekLimit, current: viewModel.weekBudget.creditCardRemainingLimit))
                    }
                }
                Section {
                    NavigationLink(value: WeeklyDetailNavigationOption.addExpense(viewModel.weekBudget)) {
                        Text(Constants.WeeklyBudgetDetailView.addExpense)
                    }
                }
                Section {
                    NavigationLink(value: WeeklyDetailNavigationOption.editBudget(viewModel.weekBudget)) {
                        Text(Constants.WeeklyBudgetDetailView.editBudget)
                    }
                }
            }
            .navigationTitle("\(Constants.WeekBudgetView.weekTitle) \(viewModel.weekBudget.week)")
            .navigationDestination(for: WeeklyDetailNavigationOption.self) { destination in
                router.getDestination(from: destination)
            }
            .toolbar {
                Button {
                    weeklyDetailMode.wrappedValue.toggle()
                } label: {
                    Label(String(), systemImage: Constants.Icons.close)
                }
            }
        }
    }
}
