//
//  BillSectionViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 22/01/24.
//

import Core
import Foundation
import Provider

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
    
    // MARK: Init From Response
    
    init(from response: BillSectionResponse) {
        self.type = .init(from: response.type)
        self.items = response.items.map({ itemResponse -> BillItemProtocol in
            if response.type == .income {
                return BillIncomeItemViewModel(from: itemResponse)
            } else {
                return BillItemViewModel(from: itemResponse)
            }
        })
    }
    
    // MARK: Methods
    
    func getResponse() -> BillSectionResponse {
        return BillSectionResponse(
            items: items.map({ viewModel -> BillItemResponse in return viewModel.getResponse() }),
            type: .init(rawValue: type.rawValue) ?? .expense
        )
    }
}
