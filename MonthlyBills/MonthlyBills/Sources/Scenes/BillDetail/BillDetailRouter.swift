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
    func routeToIncome(monthId: String)
}

final class BillDetailRouter: UIVIPRouter, BillDetailRouting {
    
    // MARK: Methods
    
    func routeToIncome(monthId: String) {
        let controller = IncomeFormFactory.configure(monthId: monthId)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}