//
//  BillItemFormType.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 17/01/24.
//

import Foundation

enum BillItemFormType: Equatable {
    case new(String)
    case edit(String, String, BillTypeViewModel)
    case template
    case templateEdit(String, BillTypeViewModel)
    
    private var id: Int {
        switch self {
        case .new:
            return 0
        case .edit:
            return 1
        case .template:
            return 2
        case .templateEdit:
            return 3
        }
    }
    
    static func == (lhs: BillItemFormType, rhs: BillItemFormType) -> Bool {
        return lhs.id == rhs.id
    }
}
