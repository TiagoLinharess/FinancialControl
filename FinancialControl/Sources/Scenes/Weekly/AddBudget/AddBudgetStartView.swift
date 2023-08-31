//
//  AddBudgetStartView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SharpnezDesignSystem
import SwiftUI

struct AddBudgetStartView: View {
    
    // MARK: Properties
    
    @Binding var closeFlow: Bool
    
    // MARK: Body
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FullMonthFormView()
                    } label: {
                        VStack(alignment: .leading, spacing: .smaller) {
                            Text("All month")
                                .font(.title2)
                            Text("Add budget for all weeks in the month")
                        }
                    }
                }
                Section {
                    NavigationLink {
                        SingleWeekFormView(closeFlow: $closeFlow)
                    } label: {
                        VStack(alignment: .leading, spacing: .smaller) {
                            Text("One week")
                                .font(.title2)
                            Text("Add budget for only a single week")
                        }
                    }
                }
            }
            .navigationTitle("Add Budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    closeFlow.toggle()
                } label: {
                    Label(String(), systemImage: "xmark")
                }
            }
        }
    }
}
