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
    func presentItem(bill: MonthlyBillsViewModel, itemId: String, sectionType: BillTypeViewModel)
    func presentTemplate(templateItem: BillItemProtocol, sectionType: BillTypeViewModel)
    func presentBillTypes(billTypesViewModel: [BillTypeViewModel])
}

final class BillItemFormPresenter: UIVIPPresenter<BillItemFormViewControlling>, BillItemFormPresenting {
    
    // MARK: Methods
    
    func presentError(error: Error) {
        viewController?.presentError(errorMessage: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
    
    func presentSuccess() {
        viewController?.presentSuccess()
    }
    
    func presentItem(bill: MonthlyBillsViewModel, itemId: String, sectionType: BillTypeViewModel) {
        if let item = bill.sections
            .first(where: { $0.type.name == sectionType.name })?.items
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
    
    func presentTemplate(templateItem: BillItemProtocol, sectionType: BillTypeViewModel) {
        let viewModel = BillItemFormViewModel(
            formType: .templateEdit(templateItem.id, sectionType),
            billType: sectionType,
            status: templateItem.status,
            name: templateItem.name,
            validateTemplateValue: templateItem.value != .zero,
            value: templateItem.value,
            validateInstallment: templateItem.installment != nil,
            installment: templateItem.installment
        )
        viewController?.presentItem(viewModel: viewModel)
    }
    
    func presentBillTypes(billTypesViewModel: [BillTypeViewModel]) {
        viewController?.presentBillTypes(billTypesViewModel: billTypesViewModel)
    }
}
