//
//  BillDetailRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

final class BillDetailRouterMock: BillDetailRouting {
    var didRouteToForm: Bool = false
    
    func routeToItemForm(at item: MonthlyBills.BillItemFormType, animated: Bool) {
        didRouteToForm = true
    }
}
