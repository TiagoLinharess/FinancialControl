//
//  BillDetailViewControllerMock.swift
//  MonthlyBillsTests
//
//  Created by Tiago Linhares on 26/02/24.
//

@testable import MonthlyBills
import UIKit

final class BillDetailViewControllerMock: UIViewController, BillDetailViewControlling {
    let router: BillDetailRouting?
    var didPresentSuccess: Bool = false
    var didPresentError: Bool = false
    
    init(router: BillDetailRouting? = nil) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentSuccess(newBill: MonthlyBills.MonthlyBillsViewModel) {
        didPresentSuccess = true
    }
    
    func presentError(message: String) {
        didPresentError = true
    }
}
