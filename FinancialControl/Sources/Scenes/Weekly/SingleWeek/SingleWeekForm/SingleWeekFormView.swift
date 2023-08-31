//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct SingleWeekFormView: View {
    
    @Environment(\.weeklyModalMode) var flowPresented
    
    var body: some View {
        Text("form here")
            .navigationTitle("Add Budget for this week")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    flowPresented.wrappedValue.toggle()
                } label: {
                    Label(String(), systemImage: "xmark")
                }
            }
    }
}
