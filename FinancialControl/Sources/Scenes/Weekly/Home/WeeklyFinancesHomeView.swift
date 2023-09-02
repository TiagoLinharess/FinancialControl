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
                .font(.title3)
            Button {
                didTapAddFinancial()
            } label: {
                Label(Constants.Commons.addFinance, systemImage: Constants.Icons.pencil)
            }
            .primarySHStyle(backgroundColor: .blue, foregroundColor: .white, font: .body)
        }
        .fullScreenCover(isPresented: $viewModel.addBudgetFlowPresented) {
            // TODO WHEN CLOSE FLOW
        } content: {
            AddWeeklyBudgetStartView()
                .environment(\.weeklyModalMode, $viewModel.addBudgetFlowPresented)
        }
    }
    
    // MARK: Methods
    
    func didTapAddFinancial() {
        viewModel.addBudgetFlowPresented.toggle()
    }
}
