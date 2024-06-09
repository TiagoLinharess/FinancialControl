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
    func select(at item: BillItemFormType)
    func delete(at indexPath: IndexPath)
}

final class BillDetailViewController: UIVIPBaseViewController<BillDetailView, BillDetailInteracting, BillDetailRouting> {
    
    // MARK: Properties
    
    private let billId: String
    private var bill: MonthlyBillsViewModel?
    
    // MARK: View Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetch(with: billId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.add), style: .plain, target: self, action: #selector(addAction))
        let templateButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapTemplateButton))
        
        navigationItem.rightBarButtonItems = [addButton, templateButton]
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
    
    // MARK: Actions
    
    @objc
    func addAction() {
        router.routeToItemForm(at: .new(billId), animated: true)
    }
    
    @objc
    func didTapTemplateButton() {
        fetchTemplates()
    }
    
    private func fetchTemplates() {
        interactor.fetchTemplates(billId: billId)
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
    
    func select(at item: BillItemFormType) {
        router.routeToItemForm(at: item, animated: true)
    }
    
    func delete(at indexPath: IndexPath) {
        guard let bill else { return }
        let itemId = bill.sections[indexPath.section].items[indexPath.row].id
        interactor.delete(itemId: itemId, billId: billId)
    }
}
