//
//  BillTotalItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

struct BillTotalItemViewModel: BillItemProtocol {
    
    // MARK: Properties
    
    let id: String = String()
    let name: String
    let value: Double
    let status: BillStatus = .none
    let installment: BillInstallment? = nil
    
    // MARK: Methods
    
    func getName() -> String {
        return name
    }
    
    func getValue() -> String {
        return value.toCurrency()
    }
}
