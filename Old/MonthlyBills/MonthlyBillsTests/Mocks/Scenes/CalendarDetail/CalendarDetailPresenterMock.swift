//
//  CalendarDetailPresenterMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import Foundation

final class CalendarDetailPresenterMock: CalendarDetailPresenting {
    
    var didPresentSuccess = false
    var didPresentError = false
    
    func presentSuccess(newCalendar: AnnualCalendarViewModel) {
        didPresentSuccess = true
    }
    
    func presentError(error: Error) {
        didPresentError = true
    }
}
