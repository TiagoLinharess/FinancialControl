//
//  
//  BillDetailViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol BillDetailViewControlling {
    func presentSuccess(newBill: MonthlyBillsViewModel)
    func presentError(message: String)
}

protocol BillDetailViewControllerDelegate {
    func getBill() -> MonthlyBillsViewModel?
    func navigateToIncomes()
    func navigateToInvestments()
    func navigateToExpenses()
}

final class BillDetailViewController: UIVIPBaseViewController<BillDetailView, BillDetailInteracting, BillDetailRouting> {
    
    // MARK: Properties
    
    private let billId: String
    private var bill: MonthlyBillsViewModel?
    
    // MARK: View Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.update(with: billId)
    }
    
    // MARK: Init
    
    init(
        billId: String,
        customView: BillDetailView,
        interactor: BillDetailInteracting,
        router: BillDetailRouting
    ) {
        self.billId = billId
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: Configure
    
    private func configure() {
        guard let bill else { return }
        title = bill.month
        customView.configure()
    }
}

extension BillDetailViewController: BillDetailViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(newBill: MonthlyBillsViewModel) {
        self.bill = newBill
        configure()
    }
    
    func presentError(message: String) {
        presentFeedbackDialog(
            with: FeedbackModel(
                title: CoreConstants.Commons.AlertTitle,
                description: message,
                buttons: [.init(title: CoreConstants.Commons.ok, style: .default)]
            )
        )
    }
}

extension BillDetailViewController: BillDetailViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getBill() -> MonthlyBillsViewModel? {
        return bill
    }
    
    func navigateToIncomes() {
        //todo
    }
    
    func navigateToInvestments() {
        //todo
    }
    
    func navigateToExpenses() {
        //todo
    }
}
