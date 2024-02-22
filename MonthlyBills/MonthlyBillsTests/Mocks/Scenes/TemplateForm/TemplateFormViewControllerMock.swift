//
//  TemplateFormViewControllerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 21/02/24.
//

@testable import MonthlyBills
import UIKit

final class TemplateFormViewControllerMock: UIViewController, AddAnnualCalendarViewControlling {
    let router: TemplateFormRouting?
    var didSetYears: Bool = false
    var didPresentSuccess: Bool = false
    var didPresentError: Bool = false
    
    init(router: TemplateFormRouting? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setYears(years: [String]) {
        didSetYears = true
    }
    
    func presentSuccess() {
        didPresentSuccess = true
    }
    
    func presentError(message: String?) {
        didPresentError = true
    }
}
