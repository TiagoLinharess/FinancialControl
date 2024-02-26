//
//  
//  BillDetailPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol BillDetailPresenting {
    func presentSuccess(newBill: MonthlyBillsViewModel)
    func presentError(error: Error)
}

final class BillDetailPresenter: UIVIPPresenter<BillDetailViewControlling>, BillDetailPresenting {
    
    // MARK: Methods
    
    func presentSuccess(newBill: MonthlyBillsViewModel) {
        viewController?.presentSuccess(newBill: newBill)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
