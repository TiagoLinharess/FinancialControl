//
//  WeekExpenseView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 01/11/23.
//

import Core
import SharpnezDesignSystem
import SwiftUI

struct WeekExpenseView: View {
    
    let expense: WeeklyExpenseViewModel
    @State private var showDescription: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            Label {
                Text(expense.title)
                    .lineLimit(1)
                Spacer()
                Text(expense.value.toCurrency())
                    .lineLimit(1)
                    .layoutPriority(1)
            } icon: {
                Image(systemName: expense.paymentMode == .debit ? CoreConstants.Icons.cash : CoreConstants.Icons.creditCard)
            }
            .frame(height: .xxBig)
            if showDescription && !expense.description.isEmpty {
                Text(expense.description)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                showDescription.toggle()
            }
        }
    }
}
