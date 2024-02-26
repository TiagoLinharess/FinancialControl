//
//  
//  BillItemFormRouter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol BillItemFormRouting {
    func close(animated: Bool)
}

final class BillItemFormRouter: UIVIPRouter, BillItemFormRouting {
    
    // MARK: Methods
    
    func close(animated: Bool) {
        viewController?.navigationController?.popViewController(animated: animated)
    }
}
