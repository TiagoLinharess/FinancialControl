//
//  WeeklyExpenseResponse.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

class WeeklyExpenseResponse: Identifiable, Codable {
    
    let id: String
    let title: String
    let description: String
    let paymentMode: PaymentMode
    let value: Double
    
    init(from viewModel: WeeklyExpenseViewModel) {
        self.id = viewModel.id
        self.title = viewModel.title
        self.description = viewModel.description
        self.paymentMode = viewModel.paymentMode
        self.value = viewModel.value
    }
}
