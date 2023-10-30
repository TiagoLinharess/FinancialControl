//
//  WeekBudgetView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import SwiftUI

struct WeekBudgetView: View {
    
    // MARK: Properties
    
    @State var presentDetail: Bool = false
    @Binding var weekBudget: WeeklyBudgetViewModel
    
    // MARK: Body
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: .small) {
                Label {
                    Text(Constants.WeekBudgetView.weekTitle)
                    Spacer()
                    Text(weekBudget.week)
                } icon: {
                    Image(systemName: Constants.Icons.monthlyCalendar)
                }
                Label {
                    Text(Constants.WeekBudgetView.budgetTitle)
                    Spacer()
                    Text(weekBudget.currentBudget.toCurrency())
                        .lineLimit(1)
                        .foregroundColor(.budgetColor(
                                total: weekBudget.originalBudget,
                                current: weekBudget.currentBudget
                            ))
                } icon: {
                    Image(systemName: Constants.Icons.cash)
                }
                Label {
                    Text(Constants.WeekBudgetView.creditCardTitle)
                    Spacer()
                    Text(weekBudget.creditCardRemainingLimit.toCurrency())
                        .lineLimit(1)
                        .foregroundColor(.budgetColor(
                                total: weekBudget.creditCardWeekLimit,
                                current: weekBudget.creditCardRemainingLimit
                            ))
                } icon: {
                    Image(systemName: Constants.Icons.creditCard)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                presentDetail = true
            }
        }
        .sheet(isPresented: $presentDetail) {
            weekBudget.currentBudget = 10
        } content: {
            WeeklyBudgetDetailView(viewModel: WeeklyBudgetDetailViewModel(weekBudget: $weekBudget))
                .environment(\.weeklyDetailMode, $presentDetail)
        }
    }
}
