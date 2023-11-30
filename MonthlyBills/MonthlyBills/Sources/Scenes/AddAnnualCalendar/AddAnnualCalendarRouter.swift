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
}

final class AddAnnualCalendarRouter: UIVIPRouter, AddAnnualCalendarRouting {
    
    // MARK: Methods
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
