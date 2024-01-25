//
//  
//  BillItemFormPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import Core
import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol BillItemFormPresenting {
    func presentError(error: Error)
    func presentSuccess()
}

final class BillItemFormPresenter: UIVIPPresenter<BillItemFormViewControlling>, BillItemFormPresenting {
    
    // MARK: Methods
    
    func presentError(error: Error) {
        viewController?.presentError(errorMessage: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
    
    func presentSuccess() {
        viewController?.presentSuccess()
    }
}
