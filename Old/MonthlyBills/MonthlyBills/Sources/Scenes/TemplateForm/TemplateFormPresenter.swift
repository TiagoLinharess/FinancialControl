//
//  
//  TemplateFormPresenter.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol TemplateFormPresenting {
    func presentSuccess(templates: [BillSectionViewModel])
    func presentError(error: Error)
}

final class TemplateFormPresenter: UIVIPPresenter<TemplateFormViewControlling>, TemplateFormPresenting {
    
    // MARK: Methods
    
    func presentSuccess(templates: [BillSectionViewModel]) {
        viewController?.presentSuccess(templates: templates)
    }
    
    func presentError(error: Error) {
        viewController?.presentError(errorMessage: (error as? CoreError)?.message ?? CoreError.genericError.message)
    }
}
