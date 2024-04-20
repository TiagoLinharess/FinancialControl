//
//  HomePresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import UIKit

final class HomePresenterMock: HomePresenting {
    
    var calendars: [MonthlyBills.AnnualCalendarViewModel]?
    var didPresentSuccess = false
    var didPresentError = false
    var error: Error?
    
    func presentSuccess(calendars: [AnnualCalendarViewModel]) {
        didPresentSuccess = true
        self.calendars = calendars
    }
    
    func presentError(error: Error) {
        didPresentError = true
        self.error = error
    }
}
