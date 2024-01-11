//
//  HomeMockController.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 11/01/24.
//

@testable import MonthlyBills
import UIKit

class HomeMockController: UIViewController {
    
    var calendars: [MonthlyBills.AnnualCalendarViewModel] = []
    var didPresentSuccess = false
    var didPresentEmpty = false
    var didPresentError = false
    var errorMessage: String?
    
    let router: HomeRouter?
    
    init(router: HomeRouter? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeMockController: AddBillDelegate {

    func didAddBill() {
        // do nothing
    }
}

extension HomeMockController: HomeViewControlling {
    
    func presentSuccess(calendars: [MonthlyBills.AnnualCalendarViewModel]) {
        self.calendars = calendars
        didPresentSuccess = true
    }
    
    func presentEmpty() {
        self.calendars = []
        didPresentEmpty = true
    }
    
    func presentError(message: String?) {
        self.calendars = []
        didPresentError = true
        self.errorMessage = message
    }
}
