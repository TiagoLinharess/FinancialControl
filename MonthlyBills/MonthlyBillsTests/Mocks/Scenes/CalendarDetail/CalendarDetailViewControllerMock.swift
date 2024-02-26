//
//  CalendarDetailViewControllerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 25/02/24.
//

@testable import MonthlyBills
import UIKit

final class CalendarDetailViewControllerMock: UIViewController, CalendarDetailViewControlling {
    let router: CalendarDetailRouting?
    var didPresentSuccess: Bool = false
    var didPresentError: Bool = false
    
    init(router: CalendarDetailRouting? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentSuccess(newCalendar: AnnualCalendarViewModel) {
        didPresentSuccess = true
    }
    
    func presentError(message: String) {
        didPresentError = true
    }
}
