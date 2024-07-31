//
//  BillStatus.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation
import Provider

enum BillStatus: String, CaseIterable {
    case payed
    case pending
    
    init(from response: BillItemResponse.BillStatus) {
        self = .init(rawValue: response.rawValue) ?? .pending
    }
}

