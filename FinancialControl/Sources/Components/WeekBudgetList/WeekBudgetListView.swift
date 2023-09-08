//
//  WeekBudgetListView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import SwiftUI

struct WeekBudgetListView: View {
    
    // MARK: Properties
    
    let weeks: [WeeklyBudgetViewModel]
    
    // MARK: Body
    
    var body: some View {
        List {
            ForEach(weeks) { week in
                WeekBudgetView(weekBudget: week)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

