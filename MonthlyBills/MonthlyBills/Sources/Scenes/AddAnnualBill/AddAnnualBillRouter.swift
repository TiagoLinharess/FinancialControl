//
//  AddAnnualBillRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Foundation
import SharpnezDesignSystem

protocol AddAnnualBillRouting {
    func close()
}

final class AddAnnualBillRouter: UIVIPRouter, AddAnnualBillRouting {
    
    // MARK: Methods
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
