//
//  InvestmentViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation

struct InvestmentViewModel {
    
    // MARK: - Properties
    
    var shares: Double
    var privatePension: Double
    var other: Double
    
    var total: Double {
        shares + privatePension + other
    }
}
