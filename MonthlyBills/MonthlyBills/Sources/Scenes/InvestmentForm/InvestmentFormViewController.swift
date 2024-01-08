//
//  
//  InvestmentFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol InvestmentFormViewControlling {
    func finishEdit()
    func presentSuccess(notes: String, investmentViewModel: InvestmentViewModel?)
    func presentError(message: String)
}

final class InvestmentFormViewController: UIVIPBaseViewController<InvestmentFormView, InvestmentFormInteracting, InvestmentFormRouting> {
    
    // MARK: Properties
    
    private let billId: String
    
    // MARK: Init
    
    init(
        billId: String,
        customView: InvestmentFormView,
        interactor: InvestmentFormInteracting,
        router: InvestmentFormRouting
    ) {
        self.billId = billId
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchInvestment(from: billId)
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.investmentsKey
        let doneButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    // MARK: Actions
    
    @objc
    func doneAction() {
        let viewModel = customView.buildViewModel()
        let notes = customView.buildNotes()
        interactor.submit(notes: notes, investmentViewModel: viewModel, billId: billId)
    }
}

extension InvestmentFormViewController: InvestmentFormViewControlling {
    
    // MARK: Controller Input
    
    func finishEdit() {
        presentFeedbackDialog(
            with: .init(
                title: CoreConstants.Commons.AlertTitle,
                description: String(format: Constants.Form.successMessage, CoreConstants.Commons.investmentsKey),
                buttons: [
                    .init(title: CoreConstants.Commons.ok, style: .default) { [weak self] _ in
                        self?.router.finish()
                    }
                ]
            )
        )
    }
    
    func presentSuccess(notes: String, investmentViewModel: InvestmentViewModel?) {
        customView.configure(notes: notes, viewModel: investmentViewModel)
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
