//
//  BillItemFormViewControllerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import UIKit

final class BillItemFormViewControllerMock: UIViewController, BillItemFormViewControlling {

    let router: BillItemFormRouting?
    var didPresentItem: Bool = false
    var didPresentSuccess: Bool = false
    var didPresentError: Bool = false
    
    init(router: BillItemFormRouting? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentItem(viewModel: MonthlyBills.BillItemFormViewModel) {
        didPresentItem = true
    }
    
    func presentSuccess() {
        didPresentSuccess = true
    }
    
    func presentError(errorMessage: String) {
        didPresentError = true
    }
}
