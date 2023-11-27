//
//  IncomeViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation

struct IncomeViewModel {
    
    // MARK: - Properties
    
    var salary: Double
    var bonus: Double
    var extra: Double
    var other: Double
    
    var total: Double {
        salary + bonus + extra + other
    }
}
