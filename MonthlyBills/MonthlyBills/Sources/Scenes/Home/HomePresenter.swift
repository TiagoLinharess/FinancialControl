//
//  HomePresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol HomePresenting {
    func presentSuccess(bills: [AnnualBillsViewModel])
    func presentError(error: Error)
}

final class HomePresenter: UIVIPPresenter<HomeViewControlling>, HomePresenting {
    
    // MARK: - Methods
    
    func presentSuccess(bills: [AnnualBillsViewModel]) {
        if bills.isEmpty {
            viewController?.presentEmpty()
            return
        }
        
        viewController?.presentSuccess(bills: bills)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message)
    }
}
