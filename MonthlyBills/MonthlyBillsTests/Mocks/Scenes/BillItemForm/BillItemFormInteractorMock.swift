//
//  BillItemFormInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

class BillItemFormInteractorMock: BillItemFormInteracting {

    var didSubmit = false
    var didConfigure = false

    func submit(viewModel: MonthlyBills.BillItemFormViewModel) {
        didSubmit = true
    }
    
    func configure(formType: MonthlyBills.BillItemFormType) {
        didConfigure = true
    }
}
