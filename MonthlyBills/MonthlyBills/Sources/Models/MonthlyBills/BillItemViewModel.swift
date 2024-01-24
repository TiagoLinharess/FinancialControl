//
//  BillItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
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
            return String(format: CoreConstants.Commons.spaceCompletion, name, installment.getFormatted())
        }
        
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
