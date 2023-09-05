//
//  Color+Extensions.swift
//  FinancialControl
//
//  Created by Tiago Linhares on 05/09/23.
//

import SwiftUI

extension Color {
    
    // MARK: Budget Color
    
    static func budgetColor(total: Double, current: Double) -> Self {
        let half = total / 2
        let oneThird = total / 3
        
        if current >= half {
            return .green
        }
        
        if current >= oneThird && current < half {
            return .yellow
        }
        
        return .red
    }
}
