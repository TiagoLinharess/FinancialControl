//
//  
//  BillTypeListViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol BillTypeListViewControlling {
    func presentBillTypes(billTypes: [BillTypeViewModel])
    func presentError(errorMessage: String)
}

final class BillTypeListViewController: UIVIPBaseViewController<BillTypeListView, BillTypeListInteracting, BillTypeListRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = Constants.BilltypesList.title
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: CoreConstants.Icons.add),
            primaryAction: UIAction(handler: { _ in self.presentAddAlert() })
        )
        
        navigationItem.rightBarButtonItems = [addButton]
    }
}

private extension BillTypeListViewController {
    
    // MARK: Private Methods
    
    func presentAddAlert() {
        let alertController = UIAlertController(
            title: Constants.BilltypesList.add,
            message: String(),
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(
            title: CoreConstants.Commons.create,
            style: .default
        ) { [weak self] _ in
            let name = (alertController.textFields?.first as? UITextField)?.text ?? String()
            self?.presentedViewController?.dismiss(animated: true)
            self?.interactor.add(name: name)
        }
        let cancelAction = UIAlertAction(
            title: CoreConstants.Commons.cancel,
            style: .destructive
        ) { [weak self] _ in
            self?.presentedViewController?.dismiss(animated: true)
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = Constants.BilltypesList.incomes
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
}

extension BillTypeListViewController: BillTypeListViewDelegate {
    
    // MARK: BillTypeListViewDelegate
    
    func toggle(id: String) {
        interactor.toggle(id: id)
    }
    
    func delete(with id: String) {
        interactor.delete(with: id)
    }
    
    func organize(billTypes: [BillTypeViewModel]) {
        interactor.organize(billTypes: billTypes)
    }
}

extension BillTypeListViewController: BillTypeListViewControlling {
    
    // MARK: Controller Input
    
    func presentBillTypes(billTypes: [BillTypeViewModel]) {
        customView.presentSuccess(billTypes: billTypes)
    }
    
    func presentError(errorMessage: String) {
        presentFeedbackDialog(
            with: FeedbackModel(
                title: CoreConstants.Commons.AlertTitle,
                description: errorMessage,
                buttons: [.init(title: CoreConstants.Commons.ok, style: .default)]
            )
        )
    }
}
