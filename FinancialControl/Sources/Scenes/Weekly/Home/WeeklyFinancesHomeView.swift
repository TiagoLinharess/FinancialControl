//
//  WeeklyFinancesHomeView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SwiftUI

struct WeeklyFinancesHomeView: View {
    
    // MARK: Properties
    
    
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: 16) {
            Text("There is no weekly financies yet")
            Button {
                didTapAddFinancial()
            } label: {
                Label("Add finance", systemImage: "pencil")
            }
        }
    }
    
    func didTapAddFinancial() {
        print("did add financial")
    }
}
