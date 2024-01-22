//
//  BillSectionViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 22/01/24.
//

import Core
import Foundation

struct BillSectionViewModel {
    
    // MARK: Properties
    
    let items: [BillItemProtocol]
    let type: BillType
    
    var total: Double {
        var total: Double = .zero
        
        items.forEach { item in
            total += item.value
        }
        
        return total
    }
    
    var title: String {
        return String(
            format: CoreConstants.Commons.divider,
            type.name,
            total.toCurrency()
        )
    }
}
