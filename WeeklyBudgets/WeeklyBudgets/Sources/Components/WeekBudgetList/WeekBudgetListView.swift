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
    var detailDisabled: Bool
    let onDelete: ((IndexSet) -> Void)?
    let onUpdate: (() -> Void)?
    
    // MARK: Init
    
    init(weeks: Binding<[WeeklyBudgetViewModel]>, deleteDisabled: Bool, detailDisabled: Bool, onDelete: ((IndexSet) -> Void)? = nil, onUpdate: (() -> Void)?) {
        self._weeks = weeks
        self.deleteDisabled = deleteDisabled
        self.detailDisabled = detailDisabled
        self.onDelete = onDelete
        self.onUpdate = onUpdate
    }
    
    // MARK: Body
    
    var body: some View {
        List {
            ForEach($weeks) { week in
                WeekBudgetView(weekBudget: week, detailDisabled: detailDisabled, onUpdate: onUpdate)
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

