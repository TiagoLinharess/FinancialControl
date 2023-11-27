//
//  WeeklyExpenseResponse.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import Foundation

public struct WeeklyExpenseResponse: Identifiable, Codable {
    
    // MARK: Payment Mode
    
    public enum PaymentMode: String, Codable, CaseIterable {
        case debit
        case credit
    }
    
    // MARK: Properties
    
    public let id: String
    public let date: Date
    public let title: String
    public let description: String
    public let paymentMode: PaymentMode
    public let value: Double
    
    // MARK: Init
    
    public init(id: String, date: Date, title: String, description: String, paymentMode: PaymentMode, value: Double) {
        self.id = id
        self.date = date
        self.title = title
        self.description = description
        self.paymentMode = paymentMode
        self.value = value
    }
}
