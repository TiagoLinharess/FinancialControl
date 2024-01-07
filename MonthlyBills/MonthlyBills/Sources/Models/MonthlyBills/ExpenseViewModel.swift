//
//  ExpenseViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation
import Provider

struct ExpenseViewModel {
    
    // MARK: Properties
    
    var housing: Double
    var transport: Double
    var feed: Double
    var health: Double
    var education: Double
    var taxes: Double
    var laisure: Double
    var clothing: Double
    var creditCard: Double
    var other: Double
    
    var total: Double {
        housing + transport + feed + health + education + taxes + creditCard + laisure + clothing + other
    }
    
    // MARK: Init
    
    init(housing: Double, transport: Double, feed: Double, health: Double, education: Double, taxes: Double, laisure: Double, clothing: Double, creditCard: Double, other: Double) {
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
    
    // MARK: Init from response
    
    init?(from response: ExpenseResponse?) {
        guard let response else { return nil }
        self.housing = response.housing
        self.transport = response.transport
        self.feed = response.feed
        self.health = response.health
        self.education = response.education
        self.taxes = response.taxes
        self.laisure = response.laisure
        self.clothing = response.clothing
        self.creditCard = response.creditCard
        self.other = response.other
    }
    
    // MARK: Methods
    
    func getResponse() -> ExpenseResponse {
        return .init(
            housing: housing,
            transport: transport,
            feed: feed,
            health: health,
            education: education,
            taxes: taxes,
            laisure: laisure,
            clothing: clothing,
            creditCard: creditCard,
            other: other
        )
    }
}
