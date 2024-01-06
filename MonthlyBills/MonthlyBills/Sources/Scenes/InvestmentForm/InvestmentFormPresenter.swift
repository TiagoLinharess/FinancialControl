//
//  
//  InvestmentFormPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol InvestmentFormPresenting {
    func finishEdit()
    func presentSuccess(notes: String, monthlyBillsViewModel: MonthlyBillsViewModel)
    func presentError(error: Error)
}

final class InvestmentFormPresenter: UIVIPPresenter<InvestmentFormViewControlling>, InvestmentFormPresenting {
    
    // MARK: Methods
    
    func finishEdit() {
        viewController?.finishEdit()
    }
    
    func presentSuccess(notes: String, monthlyBillsViewModel: MonthlyBillsViewModel) {
        viewController?.presentSuccess(notes: notes, investmentViewModel: monthlyBillsViewModel.investment)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
