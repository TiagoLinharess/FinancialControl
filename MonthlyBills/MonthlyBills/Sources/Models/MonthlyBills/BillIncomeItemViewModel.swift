//
//  BillIncomeItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation

struct BillIncomeItemViewModel: BillItemProtocol {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let value: Double
    let status: BillStatus
    let installment: BillInstallment? = nil
    
    // MARK: Methods
    
    func getName() -> String {
        return name
    }
    
    func getValue() -> String {
        return String(
            format: CoreConstants.Commons.divider,
            status.rawValue,
            value.toCurrency()
        )
    }
}
