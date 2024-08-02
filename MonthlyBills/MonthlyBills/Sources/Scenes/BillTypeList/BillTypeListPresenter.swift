//
//  
//  BillTypeListPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol BillTypeListPresenting {
    func presentSuccess(billTypes: [BillTypeViewModel])
    func presentError(error: Error)
}

final class BillTypeListPresenter: UIVIPPresenter<BillTypeListViewControlling>, BillTypeListPresenting {
    
    // MARK: Methods
    
    func presentSuccess(billTypes: [BillTypeViewModel]) {
        viewController?.presentBillTypes(billTypes: billTypes)
    }
    
    func presentError(error: Error) {
        let errorMessage = (error as? CoreError)?.message ?? error.localizedDescription
        viewController?.presentError(errorMessage: errorMessage)
    }
}
