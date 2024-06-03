//
//  WeekForm.swift
//  WeeklyBudgets
//
//  Created by Tiago Linhares on 02/06/24.
//

import Core
import CurrencyText
import SwiftUI

struct WeekForm: View {
    
    var weeks: [String]
    @State private var currencyFormatter = CurrencyFormatter.internationalDefault
    @Binding var weekSelected: String
    @Binding var weekBudget: String
    @Binding var creditCardLimit: String
    
    var body: some View {
        List {
            Section(header: Text(Constants.SingleWeekForm.pickerTitle)) {
                Picker(Constants.WeekBudgetView.weekTitle, selection: $weekSelected) {
                    ForEach(weeks, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: CoreConstants.Sizes.pickerHeight)
            }
            Section(header: Text(Constants.SingleWeekForm.budgetPlaceholder)) {
                CurrencyTextField(configuration: .init(
                    placeholder: CoreConstants.Commons.currencyPlaceholder,
                    text: $weekBudget,
                    formatter: $currencyFormatter,
                    textFieldConfiguration: nil
                ))
            }
            Section(header: Text(Constants.SingleWeekForm.creditCardPlaceholder)) {
                CurrencyTextField(configuration: .init(
                    placeholder: CoreConstants.Commons.currencyPlaceholder,
                    text: $creditCardLimit,
                    formatter: $currencyFormatter,
                    textFieldConfiguration: nil
                ))
            }
        }
    }
}
