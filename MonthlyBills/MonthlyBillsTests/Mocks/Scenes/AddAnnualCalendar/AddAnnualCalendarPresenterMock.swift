//
//  AddAnnualCalendarPresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 13/02/24.
//

@testable import MonthlyBills
import Foundation

final class AddAnnualCalendarPresenterMock: AddAnnualCalendarPresenting {
    
    var didSetYears = false
    var didPresentSuccess = false
    var didPresentError = false

    func setYears(years: [String]) {
        didSetYears = true
    }
    
    func presentSuccess() {
        didPresentSuccess = true
    }
    
    func presentError(error: Error) {
        didPresentError = true
    }
}
