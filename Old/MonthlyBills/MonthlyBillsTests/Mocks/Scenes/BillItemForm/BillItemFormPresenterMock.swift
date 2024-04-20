//
//  BillItemFormPresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

final class BillItemFormPresenterMock: BillItemFormPresenting {

    var didPresentSuccess = false
    var didPresentError = false
    var didPresentItem = false
    var didPresentTemplate = false
    
    func presentError(error: Error) {
        didPresentError = true
    }
    
    func presentSuccess() {
        didPresentSuccess = true
    }
    
    func presentItem(bill: MonthlyBills.MonthlyBillsViewModel, itemId: String, sectionType: MonthlyBills.BillType) {
        didPresentItem = true
    }
    
    func presentTemplate(templateItem: MonthlyBills.BillItemProtocol, sectionType: MonthlyBills.BillType) {
        didPresentTemplate = true
    }
}
