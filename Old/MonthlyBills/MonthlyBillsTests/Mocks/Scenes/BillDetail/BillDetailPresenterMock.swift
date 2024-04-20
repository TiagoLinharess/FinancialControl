//
//  BillDetailPresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

final class BillDetailPresenterMock: BillDetailPresenting {
    
    var didPresentSuccess = false
    var didPresentError = false
    
    func presentSuccess(newBill: MonthlyBillsViewModel) {
        didPresentSuccess = true
    }
    
    func presentError(error: Error) {
        didPresentError = true
    }
}
