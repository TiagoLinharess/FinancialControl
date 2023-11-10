//
//  Double+Extensions.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 26/10/23.
//

import Foundation

extension Double {
    
    func toCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
