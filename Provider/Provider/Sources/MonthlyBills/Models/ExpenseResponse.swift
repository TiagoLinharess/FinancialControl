//
//  ExpenseResponse.swift
//  Provider
//
//  Created by Tiago Linhares on 30/11/23.
//

import Foundation

public struct ExpenseResponse: Codable {
    
    // MARK: Properties
    
    public let housing: Double
    public let transport: Double
    public let feed: Double
    public let health: Double
    public let education: Double
    public let taxes: Double
    public let laisure: Double
    public let clothing: Double
    public let creditCard: Double
    public let other: Double
    
    // MARK: Init
    
    public init(housing: Double, transport: Double, feed: Double, health: Double, education: Double, taxes: Double, laisure: Double, clothing: Double, creditCard: Double, other: Double) {
        self.housing = housing
        self.transport = transport
        self.feed = feed
        self.health = health
        self.education = education
        self.taxes = taxes
        self.laisure = laisure
        self.clothing = clothing
        self.creditCard = creditCard
        self.other = other
    }
}
