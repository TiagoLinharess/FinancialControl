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
    func routeToItemForm(at item: BillItemFormType, animated: Bool)
}

final class BillDetailRouter: UIVIPRouter, BillDetailRouting {
    
    // MARK: Methods
    
    func routeToItemForm(at item: BillItemFormType, animated: Bool) {
        let controller = BillItemFormFactory.configure(formType: item)
        viewController?.navigationController?.pushViewController(controller, animated: animated)
    }
}
