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
            MonthlyFinancesHomeView()
                .tabItem {
                    Label(Constants.Commons.monthly, systemImage: Constants.Icons.monthlyCalendar)
                }
            
            WeeklyFinancesHomeView()
                .tabItem {
                    Label(Constants.Commons.weekly, systemImage: Constants.Icons.weeklyCalendar)
                }
        }
    }
}
