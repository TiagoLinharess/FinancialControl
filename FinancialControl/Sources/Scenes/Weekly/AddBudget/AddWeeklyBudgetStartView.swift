//
//  AddWeeklyBudgetStartView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SharpnezDesignSystem
import SwiftUI

struct AddWeeklyBudgetStartView: View {
    
    // MARK: Properties
    
    @Environment(\.weeklyModalMode) var flowPresented
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FullMonthFormView()
                    } label: {
                        VStack(alignment: .leading, spacing: .smaller) {
                            Text(Constants.AddWeeklyBudgetStart.allMonthTitle)
                                .font(.title2)
                            Text(Constants.AddWeeklyBudgetStart.allMonthDescription)
                        }
                    }
                }
                Section {
                    NavigationLink {
                        SingleWeekFormView(viewModel: SingleWeekFormViewModel())
                    } label: {
                        VStack(alignment: .leading, spacing: .smaller) {
                            Text(Constants.AddWeeklyBudgetStart.singleWeekTitle)
                                .font(.title2)
                            Text(Constants.AddWeeklyBudgetStart.singleWeekDescription)
                        }
                    }
                }
            }
            .navigationTitle(Constants.AddWeeklyBudgetStart.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    flowPresented.wrappedValue.toggle()
                } label: {
                    Label(String(), systemImage: Constants.Icons.close)
                }
            }
        }
    }
}
