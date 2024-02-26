//
//  AddAnnualCalendarInteractorMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 14/02/24.
//

import Foundation
@testable import MonthlyBills
import SharpnezCore

final class AddAnnualCalendarInteractorMock: AddAnnualCalendarInteracting {
    
    var didFetchYears: Bool = false
    var didSubmit: Bool = false
    
    func fetchAvailableYears() {
        didFetchYears = true
    }
    
    func submit(year: String) {
        didSubmit = true
    }
}
