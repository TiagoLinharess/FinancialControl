//
//  WeeklyExpenseViewModel.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 30/08/23.
//

import Provider
import Foundation

class WeeklyExpenseViewModel: Identifiable, Codable {
    
    // MARK: Properties
    
    let id: String
    var date: Date
    var title: String
    var description: String
    var paymentMode: PaymentMode
    var value: Double
    
    // MARK: Init
    
    init(title: String, description: String, paymentMode: PaymentMode, value: Double) {
        self.id = UUID().uuidString
        self.date = Date.now
        self.title = title
        self.description = description
        self.paymentMode = paymentMode
        self.value = value
    }
    
    // MARK: Init From Response
    
    init(from response: WeeklyExpenseResponse) {
        self.id = response.id
        self.date = response.date
        self.title = response.title
        self.description = response.description
        self.paymentMode = .init(rawValue: response.paymentMode.rawValue) ?? .debit
        self.value = response.value
    }
}
