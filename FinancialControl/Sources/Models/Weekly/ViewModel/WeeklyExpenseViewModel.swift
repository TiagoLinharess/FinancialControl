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
    
    init(from response: WeeklyExpenseResponse) {
        self.id = response.id
        self.title = response.title
        self.description = response.description
        self.paymentMode = response.paymentMode
        self.value = response.value
    }
}
