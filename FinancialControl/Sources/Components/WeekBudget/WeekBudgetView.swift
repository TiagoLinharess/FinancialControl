//
//  WeekBudgetView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import SwiftUI

struct WeekBudgetView: View {
    
    // MARK: Properties
    
    let weekBudget: WeeklyBudgetViewModel
    
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
                    Text(
                        String(
                            format: Constants.Commons.cash,
                            "\(weekBudget.currentBudget)"
                        )
                        .replacingOccurrences(of: ".", with: ",")
                    )
                    .foregroundColor(
                        .budgetColor(
                            total: weekBudget.originalBudget,
                            current: weekBudget.currentBudget
                        )
                    )
                } icon: {
                    Image(systemName: Constants.Icons.cash)
                }
                Label {
                    Text(Constants.WeekBudgetView.creditCardTitle)
                    Spacer()
                    Text(
                        String(
                            format: Constants.Commons.cash,
                            "\(weekBudget.creditCardRemainingLimit)"
                        )
                        .replacingOccurrences(of: ".", with: ",")
                    )
                    .foregroundColor(
                        .budgetColor(
                            total: weekBudget.creditCardWeekLimit,
                            current: weekBudget.creditCardRemainingLimit
                        )
                    )
                } icon: {
                    Image(systemName: Constants.Icons.creditCard)
                }
            }
        }
    }
}
