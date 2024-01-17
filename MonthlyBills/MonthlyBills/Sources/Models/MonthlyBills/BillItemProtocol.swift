//
//  BillItemProtocol.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

protocol BillItemProtocol {
    var id: String { get }
    var name: String { get }
    var value: Double { get }
    var status: BillStatus { get }
    var installment: BillInstallment? { get }
    
    func getName() -> String
    func getValue() -> String
}
