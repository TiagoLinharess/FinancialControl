//
//  WeekBudgetView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Core
import SwiftUI

struct WeekBudgetView: View {
    
    // MARK: Properties
    
    @Binding var weekBudget: WeeklyBudgetViewModel
    @State private var presentDetail: Bool = false
    let onUpdate: (() -> Void)?
    
    // MARK: Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: .nano) {
            titleView
            budgetView
            creditView
        }
        .contentShape(Rectangle())
        .onTapGesture {
            presentDetail.toggle()
        }
        .sheet(isPresented: $presentDetail) {
            onUpdate?()
        } content: {
            WeeklyBudgetDetailView(viewModel: WeeklyBudgetDetailViewModel(weekBudget: weekBudget))
                .environment(\.weeklyDetailMode, $presentDetail)
        }
    }
    
    // MARK: Subviews
    
    private var titleView: some View {
        HStack {
            Text(Constants.WeekBudgetView.weekTitle)
            Text(weekBudget.week)
        }
        .fontWeight(.bold)
        .font(.title3)
    }
    
    private var budgetView: some View {
        HStack {
            Text(Constants.WeekBudgetView.budgetTitle)
            Text(weekBudget.currentBudget.toCurrency())
                .lineLimit(1)
                .foregroundColor(.budgetColor(
                    total: weekBudget.originalBudget,
                    current: weekBudget.currentBudget
                ))
        }
        .font(.caption)
    }
    
    private var creditView: some View {
        HStack {
            Text(Constants.WeekBudgetView.creditCardTitle)
            Text(weekBudget.creditCardRemainingLimit.toCurrency())
                .lineLimit(1)
                .foregroundColor(.budgetColor(
                    total: weekBudget.creditCardWeekLimit,
                    current: weekBudget.creditCardRemainingLimit
                ))
        }
        .font(.caption2)
    }
}
