//
//  HomeErrorView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 07/09/23.
//

import SharpnezDesignSystem
import SwiftUI

struct HomeErrorView: View {
    
    let message: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: .small) {
            Text(message)
                .font(.title3)
            Button {
                action()
            } label: {
                Text(Constants.Commons.tryAgain)
            }
            .primarySHStyle(backgroundColor: .blue, foregroundColor: .white, font: .body)
        }
    }
}
