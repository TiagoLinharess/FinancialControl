//
//  TabContainerView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct TabContainerView: View {
    
    // MARK: Body
    
    var body: some View {
        TabView {
            WeeklyBudgetsHomeView(viewModel: WeeklyBudgetsHomeViewModel())
                .tabItem {
                    Label(Constants.Commons.weekly, systemImage: Constants.Icons.weeklyCalendar)
                }
            MonthlyFinancesHomeView()
                .tabItem {
                    Label(Constants.Commons.monthly, systemImage: Constants.Icons.monthlyCalendar)
                }
        }
    }
}
