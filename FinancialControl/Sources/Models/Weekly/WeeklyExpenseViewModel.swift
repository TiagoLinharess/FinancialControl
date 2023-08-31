//
//  WeeklyExpenseViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Foundation

class WeeklyExpenseViewModel: Identifiable, Codable {
    
    let id: String
    let title: String
    let description: String
    let paymentMode: PaymentMode
    let value: Double
    
    init(title: String, description: String, paymentMode: PaymentMode, value: Double) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.paymentMode = paymentMode
        self.value = value
    }
}
