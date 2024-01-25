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
    func presentItem(bill: MonthlyBillsViewModel, itemId: String, sectionType: BillType)
}

final class BillItemFormPresenter: UIVIPPresenter<BillItemFormViewControlling>, BillItemFormPresenting {
    
    // MARK: Methods
    
    func presentError(error: Error) {
        viewController?.presentError(errorMessage: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
    
    func presentSuccess() {
        viewController?.presentSuccess()
    }
    
    func presentItem(bill: MonthlyBillsViewModel, itemId: String, sectionType: BillType) {
        if let item = bill.sections
            .first(where: { $0.type == sectionType })?.items
            .first(where: { $0.id == itemId }) {
            let viewModel = BillItemFormViewModel(
                billType: sectionType,
                status: item.status,
                name: item.name,
                validateTemplateValue: false,
                value: item.value,
                validateInstallment: item.installment != nil,
                installment: item.installment
            )
            viewController?.presentItem(viewModel: viewModel)
        } else {
            presentError(error: CoreError.parseError)
        }
    }
}
