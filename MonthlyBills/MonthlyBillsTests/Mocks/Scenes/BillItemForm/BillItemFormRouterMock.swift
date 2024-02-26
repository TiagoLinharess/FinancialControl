//
//  BillItemFormRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import Foundation

final class BillItemFormRouterMock: BillItemFormRouting {
    
    var didClose: Bool = false
    
    func close(animated: Bool) {
        didClose = true
    }
}
