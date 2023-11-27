//
//  ExpenseViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation

struct ExpenseViewModel {
    
    // MARK: - Properties
    
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
}
