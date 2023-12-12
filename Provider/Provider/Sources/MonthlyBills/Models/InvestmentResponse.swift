//
//  InvestmentResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct InvestmentResponse: Codable {
    
    // MARK: Properties
    
    public let id: String
    public let shares: Double
    public let privatePension: Double
    public let fixedIncome: Double
    public let other: Double
    
    // MARK: Init
    
    public init(id: String, shares: Double, privatePension: Double, fixedIncome: Double, other: Double) {
        self.id = id
        self.shares = shares
        self.privatePension = privatePension
        self.fixedIncome = fixedIncome
        self.other = other
    }
}
