//
//  
//  ExpenseFormPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol ExpenseFormPresenting {
    func finishEdit()
    func presentSuccess(notes: String, monthlyBillsViewModel: MonthlyBillsViewModel)
    func presentError(error: Error)
}

final class ExpenseFormPresenter: UIVIPPresenter<ExpenseFormViewControlling>, ExpenseFormPresenting {
    
    // MARK: Methods
    
    func finishEdit() {
        viewController?.finishEdit()
    }
    
    func presentSuccess(notes: String, monthlyBillsViewModel: MonthlyBillsViewModel) {
        viewController?.presentSuccess(notes: notes, expenseViewModel: monthlyBillsViewModel.expense)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
