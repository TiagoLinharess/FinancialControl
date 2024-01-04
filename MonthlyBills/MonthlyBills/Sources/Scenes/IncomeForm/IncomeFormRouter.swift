//
//  
//  IncomeFormRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//
//

import SharpnezDesignSystem
import UIKit

protocol IncomeFormRouting {
    func finish()
}

final class IncomeFormRouter: UIVIPRouter, IncomeFormRouting {
    
    // MARK: Methods
    
    func finish() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
