//
//  BillItemFormType.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

enum BillItemFormType: Equatable {
    case new(String)
    case edit(String, String, BillType)
    case template
    case templateEdit(String, BillType)
}
