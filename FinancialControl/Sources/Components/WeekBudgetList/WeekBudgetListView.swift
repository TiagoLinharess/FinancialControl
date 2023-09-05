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
        ForEach(weeks) { week in
            List {
                WeekBudgetView(weekBudget: week)
            }
        }
    }
}

