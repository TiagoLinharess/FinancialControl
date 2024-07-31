//
//  AddAnnualCalendarRouterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 14/02/24.
//

import Foundation
@testable import MonthlyBills
import SharpnezCore

final class AddAnnualCalendarRouterMock: AddAnnualCalendarRouting {
    
    var didClose: Bool = false
    var didFinish: Bool = false

    func close() {
        didClose = true
    }
    
    func finish() {
        didFinish = true
    }
}
