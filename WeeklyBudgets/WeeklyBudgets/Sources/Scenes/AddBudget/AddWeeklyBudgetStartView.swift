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
    
    @Environment(\.weeklyModalMode) private var flowPresented
    @StateObject private var router = WeeklyRouter()
    
    // MARK: Body
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                Section {
                    NavigationLink(value: WeeklyNavigationOption.singleWeekForm) {
                        VStack(alignment: .leading, spacing: .smaller) {
                            Text(Constants.AddWeeklyBudgetStart.singleWeekTitle)
                                .font(.title2)
                            Text(Constants.AddWeeklyBudgetStart.singleWeekDescription)
                        }
                    }
                }
            }
            .navigationDestination(for: WeeklyNavigationOption.self) { destination in
                router.getDestination(from: destination)
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
