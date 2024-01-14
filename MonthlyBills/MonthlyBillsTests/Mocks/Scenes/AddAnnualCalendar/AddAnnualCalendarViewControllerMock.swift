//
//  AddAnnualCalendarViewControllerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 12/01/24.
//

@testable import MonthlyBills
import UIKit

final class AddAnnualCalendarViewControllerMock: UIViewController, AddAnnualCalendarViewControlling {
    
    let router: AddAnnualCalendarRouter?
    
    init(router: AddAnnualCalendarRouter? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setYears(years: [String]) {
        // todo
    }
    
    func presentSuccess() {
        // todo
    }
    
    func presentError(message: String?) {
        // todo
    }
}
