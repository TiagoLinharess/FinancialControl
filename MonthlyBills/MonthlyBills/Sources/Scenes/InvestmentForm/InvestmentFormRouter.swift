//
//  
//  InvestmentFormRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol InvestmentFormRouting {
    func finish()
}

final class InvestmentFormRouter: UIVIPRouter, InvestmentFormRouting {
    
    // MARK: Methods
    
    func finish() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
