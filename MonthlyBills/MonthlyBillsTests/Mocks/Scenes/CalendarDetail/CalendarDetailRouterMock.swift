//
//  CalendarDetailRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import Foundation

final class CalendarDetailRouterMock: CalendarDetailRouting {
    var didRouteToBill: Bool = false
    var didClose: Bool = false
    
    func routeToBill(billId: String, animated: Bool) {
        didRouteToBill = true
    }
    
    func close() {
        didClose = true
    }
}
