//
//  HomeErrorView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 07/09/23.
//

import Core
import SharpnezDesignSystem
import SwiftUI

struct HomeErrorView: View {
    
    // MARK: Properties
    
    let message: String
    let action: () -> Void
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: .small) {
            Text(message)
                .font(.title3)
            Button {
                action()
            } label: {
                Text(CoreConstants.Commons.tryAgain)
            }
            .primarySHStyle(backgroundColor: .blue, foregroundColor: .white, font: .body)
        }
    }
}
