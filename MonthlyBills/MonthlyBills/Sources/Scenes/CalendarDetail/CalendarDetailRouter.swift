//
//  
//  CalendarDetailRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import SharpnezDesignSystem
import UIKit

protocol CalendarDetailRouting {
    func routeToBill(bill: MonthlyBillsViewModel)
    func close()
}

final class CalendarDetailRouter: UIVIPRouter, CalendarDetailRouting {
    
    // MARK: Methods
    
    func routeToBill(bill: MonthlyBillsViewModel) {
        let controller = BillDetailFactory.configure(bill: bill)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
