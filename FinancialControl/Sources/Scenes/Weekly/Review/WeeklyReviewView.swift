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
        VStack(spacing: .small) {
            ForEach(viewModel.weeks) { week in
                List {
                    Section {
                        VStack(alignment: .leading, spacing: .small) {
                            Label("Week \(week.week)", systemImage: Constants.Icons.monthlyCalendar)
                            Label("Budget $\(week.originalBudget)", systemImage: "dollarsign")
                            Label("Credit card limit $\(week.creditCardWeekLimit)", systemImage: "creditcard")
                        }
                    }
                }
            }
        }
    }
}
