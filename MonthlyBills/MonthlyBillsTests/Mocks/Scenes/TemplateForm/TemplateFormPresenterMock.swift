//
//  TemplateFormPresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

@testable import MonthlyBills
import Foundation

final class TemplateFormPresenterMock: TemplateFormPresenting {
    
    var didPresentSuccess = false
    var didPresentError = false
    
    func presentSuccess(templates: [MonthlyBills.BillSectionViewModel]) {
        didPresentSuccess = true
    }
    
    func presentError(error: Error) {
        didPresentError = true
    }
}
