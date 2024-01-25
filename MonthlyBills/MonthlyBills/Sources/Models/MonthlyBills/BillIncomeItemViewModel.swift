//
//  BillIncomeItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation
import Provider

struct BillIncomeItemViewModel: BillItemProtocol {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let value: Double
    let status: BillStatus
    let installment: BillInstallment? = nil
    
    // MARK: Init
    
    init(id: String = UUID().uuidString, name: String, value: Double, status: BillStatus) {
        self.id = id
        self.name = name
        self.value = value
        self.status = status
    }
    
    // MARK: Init From Response
    
    init(from response: BillItemResponse) {
        self.id = response.id
        self.name = response.name
        self.value = response.value
        self.status = .init(from: response.status)
    }
    
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
    
    func getResponse() -> BillItemResponse {
        return BillItemResponse(
            id: id,
            name: name,
            value: value,
            status: .init(rawValue: status.rawValue) ?? .pending,
            installment: nil
        )
    }
}
