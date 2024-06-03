//
//  BillType.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation
import Provider

enum BillType: String, CaseIterable {
    case income
    case investment
    case expense
    case creditCard
    
    var name: String {
        switch self {
        case .income:
            return CoreConstants.Commons.incomesKey
        case .investment:
            return CoreConstants.Commons.investmentsKey
        case .expense:
            return CoreConstants.Commons.expensesKey
        case .creditCard:
            return CoreConstants.Commons.creditCardKey
        }
    }
    
    init(from response: BillSectionResponse.BillType) {
        self = .init(rawValue: response.rawValue) ?? .expense
    }
    
    func getResponse() -> BillSectionResponse.BillType {
        return .init(rawValue: self.rawValue) ?? .expense
    }
}