//
//  
//  TemplateFormRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol TemplateFormRouting {
    func routeToItemForm(at item: BillItemFormType)
}

final class TemplateFormRouter: UIVIPRouter, TemplateFormRouting {
    
    // MARK: Methods
    
    func routeToItemForm(at item: BillItemFormType) {
        let controller = BillItemFormFactory.configure(formType: item)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
