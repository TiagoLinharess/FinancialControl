//
//  BillDetailInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

class BillDetailInteractorMock: BillDetailInteracting {
    
    var fetchCalled = false
    var fetchTemplatesCalled = false
    var deleteCalled = false
    
    func fetch(with id: String) {
        fetchCalled = true
    }
    
    func fetchTemplates(billId: String) {
        fetchTemplatesCalled = true
    }
    
    func delete(itemId: String, billId: String) {
        deleteCalled = true
    }
}
