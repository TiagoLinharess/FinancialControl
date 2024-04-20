//
//  TemplateFormRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 22/02/24.
//

@testable import MonthlyBills
import Foundation

final class TemplateFormRouterMock: TemplateFormRouting {
    var didRouteToForm: Bool = false
    var didClose: Bool = false
    
    func routeToItemForm(at item: MonthlyBills.BillItemFormType, animated: Bool) {
        didRouteToForm = true
    }
    
    func close(animated: Bool) {
        didClose = true
    }
}
