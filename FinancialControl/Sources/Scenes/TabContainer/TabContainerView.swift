//
//  TabContainerView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct TabContainerView: View {
    var body: some View {
        TabView {
            WeeklyFinancesHomeView()
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
