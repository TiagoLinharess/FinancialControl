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
    
    var totalPending: Double {
        return total(for: .pending)
    }
    
    var totalPayed: Double {
        return total(for: .payed)
    }
    
    var total: Double {
        return totalPayed + totalPending
    }
    
    var title: String {
        return String(
            format: CoreConstants.Commons.divider,
            type.name,
            total.toCurrency()
        )
    }
    
    // MARK: Init
    
    init(items: [BillItemProtocol], type: BillType) {
        self.items = items
        self.type = type
    }
    
    // MARK: Init From Response
    
    init(from response: BillSectionResponse) {
        self.type = .init(from: response.type)
        self.items = response.items.map({ itemResponse -> BillItemProtocol in
            if response.type.name == BillType.income.rawValue {
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
            type: .init(id: UUID().uuidString, name: type.rawValue, isIncome: type == .income)
        )
    }
    
    private func total(for status: BillStatus) -> Double {
        return items
            .filter { $0.status == status }
            .reduce(0) { $0 + $1.value }
    }
}
