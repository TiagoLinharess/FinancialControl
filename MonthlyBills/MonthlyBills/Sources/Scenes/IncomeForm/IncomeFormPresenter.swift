//
//  
//  IncomeFormPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol IncomeFormPresenting {
    func presentSuccess(monthlyBillsViewModel: MonthlyBillsViewModel)
    func presentError(error: Error)
    func finishEdit()
}

final class IncomeFormPresenter: UIVIPPresenter<IncomeFormViewControlling>, IncomeFormPresenting {
    
    // MARK: Methods
    
    func finishEdit() {
        viewController?.finishEdit()
    }
    
    func presentSuccess(monthlyBillsViewModel: MonthlyBillsViewModel) {
        viewController?.presentSuccess(incomeViewModel: monthlyBillsViewModel.income)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
