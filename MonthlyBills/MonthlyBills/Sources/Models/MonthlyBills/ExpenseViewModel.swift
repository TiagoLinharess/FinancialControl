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
    
    let id: String
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
    
    // MARK: Init from response
    
    init?(from response: ExpenseResponse?) {
        guard let response else { return nil }
        self.id = response.id
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
            id: id,
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
