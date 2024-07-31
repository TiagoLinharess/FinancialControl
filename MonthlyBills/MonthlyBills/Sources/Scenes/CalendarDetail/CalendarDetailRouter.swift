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
    func routeToBill(billId: String, animated: Bool)
    func close()
}

final class CalendarDetailRouter: UIVIPRouter, CalendarDetailRouting {
    
    // MARK: Methods
    
    func routeToBill(billId: String, animated: Bool) {
        let controller = BillDetailFactory.configure(billId: billId)
        viewController?.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func close() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
