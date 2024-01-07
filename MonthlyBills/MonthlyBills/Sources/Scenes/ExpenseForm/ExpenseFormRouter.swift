//
//  
//  ExpenseFormRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol ExpenseFormRouting {
    func finish()
}

final class ExpenseFormRouter: UIVIPRouter, ExpenseFormRouting {
    
    // MARK: Methods
    
    func finish() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
