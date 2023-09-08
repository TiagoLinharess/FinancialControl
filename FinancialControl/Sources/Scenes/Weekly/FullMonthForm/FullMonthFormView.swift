//
//  FullMonthFormView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct FullMonthFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Text("Will be implemented")
                .navigationTitle("Add Budget for this week")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Label(String(), systemImage: "xmark")
                    }
                }
        }
    }
}
