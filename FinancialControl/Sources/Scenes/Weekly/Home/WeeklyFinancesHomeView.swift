//
//  WeeklyFinancesHomeView.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import SharpnezDesignSystem
import SwiftUI

struct WeeklyFinancesHomeView<ViewModel: WeeklyFinancesHomeViewModelProtocol>: View {
    
    // MARK: Properties
    
    @StateObject var viewModel: ViewModel
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: .small) {
            Text(Constants.WeeklyHome.emptyTitle)
                .configureWithSH(color: .white, font: .title3)
            Button {
                didTapAddFinancial()
            } label: {
                Label(Constants.Commons.addFinance, systemImage: Constants.Icons.pencil)
            }
            .primarySHStyle(backgroundColor: .blue, foregroundColor: .white, font: .body)
        }
    }
    
    // MARK: Methods
    
    func didTapAddFinancial() {
        print("did add financial")
    }
}
