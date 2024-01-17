//
//
//  BillDetailRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//
//

import SharpnezDesignSystem
import UIKit

protocol BillDetailRouting {
    func addItem(billId: String)
    func editItem(at itemToEdit: EditBillItemViewModel)
}

final class BillDetailRouter: UIVIPRouter, BillDetailRouting {
    
    // MARK: Methods
    
    func addItem(billId: String) {
        // todo
    }
    
    func editItem(at itemToEdit: EditBillItemViewModel) {
        // todo
    }
}
