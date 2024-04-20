//
//  BillInstallment.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation
import Provider

struct BillInstallment {
    
    // MARK: Properties
    
    let current: Int
    let max: Int
    
    // MARK: Methods
    
    func getFormatted() -> String {
        return String(format: CoreConstants.Commons.barCompletion, String(current), String(max))
    }
    
    func isValid() -> Bool {
        return current <= max && max > .zero && current > .zero
    }
    
    func getResponse() -> BillItemResponse.BillInstallment {
        return .init(current: current, max: max)
    }
}
