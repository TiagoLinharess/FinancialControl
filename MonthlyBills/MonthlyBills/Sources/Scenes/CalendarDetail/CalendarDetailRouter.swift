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
    func routeToBill(billId: String)
    func close()
}

final class CalendarDetailRouter: UIVIPRouter, CalendarDetailRouting {
    
    // MARK: Methods
    
    func routeToBill(billId: String) {
        let controller = BillDetailFactory.configure(billId: billId)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
