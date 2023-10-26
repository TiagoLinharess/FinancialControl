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
    let deleteDisabled: Bool
    let onDelete: ((IndexSet) -> Void)?
    
    // MARK: Init
    
    init(weeks: Binding<[WeeklyBudgetViewModel]>, deleteDisabled: Bool, onDelete: ((IndexSet) -> Void)? = nil) {
        self._weeks = weeks
        self.deleteDisabled = deleteDisabled
        self.onDelete = onDelete
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            ForEach(weeks) { week in
                WeekBudgetView(weekBudget: week)
            }
            .onDelete(perform: delete)
            .deleteDisabled(deleteDisabled)
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    func delete(at offsets: IndexSet) {
        onDelete?(offsets)
    }
}

