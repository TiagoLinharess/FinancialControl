//
//  AddAnnualBillPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//
import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol AddAnnualBillPresenting {
    func setYears(years: [String])
    func presentSuccess()
    func presentError(error: Error)
}

final class AddAnnualBillPresenter: UIVIPPresenter<AddAnnualBillViewControlling>, AddAnnualBillPresenting {
    
    // MARK: Methods
    
    func setYears(years: [String]) {
        viewController?.setYears(years: years)
    }
    
    func presentSuccess() {
        viewController?.presentSuccess()
    }
    
    func presentError(error: Error) {
        viewController?.presentError(message: (error as? CoreError)?.message)
    }
}
