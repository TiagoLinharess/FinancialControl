//
//  
//  ExpenseFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol ExpenseFormViewControlling {
    func finishEdit()
    func presentSuccess(notes: String, expenseViewModel: ExpenseViewModel?)
    func presentError(message: String)
}

final class ExpenseFormViewController: UIVIPBaseViewController<ExpenseFormView, ExpenseFormInteracting, ExpenseFormRouting> {
    
    // MARK: Properties
    
    private let billId: String
    
    // MARK: Init
    
    init(
        billId: String,
        customView: ExpenseFormView,
        interactor: ExpenseFormInteracting,
        router: ExpenseFormRouting
    ) {
        self.billId = billId
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.expensesKey
        let doneButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    // MARK: Actions
    
    @objc
    func doneAction() {
        let viewModel = customView.buildViewModel()
        let notes = customView.buildNotes()
        interactor.submit(notes: notes, expenseViewModel: viewModel, billId: billId)
    }
}

extension ExpenseFormViewController: ExpenseFormViewControlling {
    
    // MARK: Controller Input
    
    func finishEdit() {
        presentFeedbackDialog(
            with: .init(
                title: CoreConstants.Commons.AlertTitle,
                description: Constants.AddAnnualCalendarView.successMessage,
                buttons: [
                    .init(title: CoreConstants.Commons.ok, style: .default) { [weak self] _ in
                        self?.router.finish()
                    }
                ]
            )
        )
    }
    
    func presentSuccess(notes: String, expenseViewModel: ExpenseViewModel?) {
        customView.configure(notes: notes, viewModel: expenseViewModel)
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
