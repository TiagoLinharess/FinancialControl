//
//  AddAnnualCalendarRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation
import SharpnezDesignSystem

protocol AddAnnualCalendarRouting {
    func close()
    func finish()
}

final class AddAnnualCalendarRouter: UIVIPRouter, AddAnnualCalendarRouting {
    
    // MARK: Properties
    
    var addBillDelegate: AddBillDelegate?
    
    // MARK: Methods
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    
    func finish() {
        viewController?.navigationController?.dismiss(animated: true) { [weak self] in
            self?.addBillDelegate?.didAddBill()
        }
    }
}
