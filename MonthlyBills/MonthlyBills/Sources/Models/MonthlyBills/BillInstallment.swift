//
//  BillInstallment.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

struct BillInstallment {
    
    // MARK: Properties
    
    let current: Int
    let max: Int
    
    // MARK: Methods
    
    func getFormatted() -> String {
        "\(current)/\(max)" // todo
    }
}
