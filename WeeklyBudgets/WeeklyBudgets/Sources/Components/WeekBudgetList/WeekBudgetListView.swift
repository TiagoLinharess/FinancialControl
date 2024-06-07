//
//  WeekBudgetListView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import SwiftUI

struct WeekBudgetListView: View {
    
    // MARK: Properties
    
    @Binding var weeks: [WeeklyBudgetViewModel]
    let onDelete: ((IndexSet) -> Void)?
    let onUpdate: (() -> Void)?
    
    // MARK: Init
    
    init(weeks: Binding<[WeeklyBudgetViewModel]>, onDelete: ((IndexSet) -> Void)? = nil, onUpdate: (() -> Void)? = nil) {
        self._weeks = weeks
        self.onDelete = onDelete
        self.onUpdate = onUpdate
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            ForEach($weeks) { week in
                WeekBudgetView(weekBudget: week, onUpdate: onUpdate)
            }
            .onDelete(perform: delete)
            .deleteDisabled(false)
        }
        .listStyle(.plain)
    }
    
    func delete(at offsets: IndexSet) {
        onDelete?(offsets)
    }
}

