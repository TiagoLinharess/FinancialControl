//
//  SingleWeekFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct SingleWeekFormView: View {
    
    @Binding var closeFlow: Bool
    
    var body: some View {
        Text("form here")
            .navigationTitle("Add Budget for this week")
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
