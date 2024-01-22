//
//  BillType.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Core
import Foundation

enum BillType: Int, CaseIterable {
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
}
