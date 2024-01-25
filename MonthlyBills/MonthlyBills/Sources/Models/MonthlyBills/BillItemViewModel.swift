//
//  BillItemViewModel.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation
import Provider

struct BillItemViewModel: BillItemProtocol {
    
    // MARK: Properties
    
    let id: String
    let name: String
    let value: Double
    let status: BillStatus
    let installment: BillInstallment?
    
    // MARK: Init
    
    init(id: String = UUID().uuidString, name: String, value: Double, status: BillStatus, installment: BillInstallment?) {
        self.id = id
        self.name = name
        self.value = value
        self.status = status
        self.installment = installment
    }
    
    // MARK: Init From Response
    
    init(from response: BillItemResponse) {
        self.id = response.id
        self.name = response.name
        self.value = response.value
        self.status = .init(from: response.status)
        
        if let installment = response.installment {
            self.installment = .init(current: installment.current, max: installment.max)
        } else {
            self.installment = nil
        }
    }
    
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
    
    func getResponse() -> BillItemResponse {
        return BillItemResponse(
            id: id,
            name: name,
            value: value,
            status: .init(rawValue: status.rawValue) ?? .pending,
            installment: BillItemResponse.BillInstallment(current: installment?.current ?? .zero, max: installment?.max ?? .zero)
        )
    }
}
