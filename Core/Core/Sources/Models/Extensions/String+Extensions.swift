//
//  String+Extensions.swift
//  Core
//
//  Created by Tiago Linhares on 17/11/23.
//

import Foundation

public extension String {
    
    var currencyToDouble: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        return formatter.number(from: self) as? Double
    }
}
