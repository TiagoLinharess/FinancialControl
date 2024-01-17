//
//  BillItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

struct BillItemViewModel: BillItemProtocol {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let value: Double
    let status: BillStatus
    let installment: BillInstallment?
    
    // MARK: Methods
    
    func getName() -> String {
        if let installment = installment {
            return name + " " + installment.getFormatted() // todo
        }
        
        return name
    }
    
    func getValue() -> String {
        if status == .none {
            return value.toCurrency()
        }
        
        return status.rawValue + " | " + value.toCurrency() // todo
    }
}
