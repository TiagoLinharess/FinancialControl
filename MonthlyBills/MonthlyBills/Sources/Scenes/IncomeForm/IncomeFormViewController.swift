//
//  
//  IncomeFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol IncomeFormViewControlling {
    func finishEdit()
    func presentSuccess(incomeViewModel: IncomeViewModel?)
    func presentError(message: String)
}

final class IncomeFormViewController: UIVIPBaseViewController<IncomeFormView, IncomeFormInteracting, IncomeFormRouting> {
    
    // MARK: Properties
    
    private let billId: String
    
    // MARK: Init
    
    init(
        billId: String,
        customView: IncomeFormView,
        interactor: IncomeFormInteracting,
        router: IncomeFormRouting
    ) {
        self.billId = billId
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchIncome(from: billId)
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.incomesKey
        let doneButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    // MARK: Actions
    
    @objc
    func doneAction() {
        let viewModel = customView.buildViewModel()
        interactor.submit(incomeViewModel: viewModel, billId: billId)
    }
}

extension IncomeFormViewController: IncomeFormViewControlling {
    
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
    
    func presentSuccess(incomeViewModel: IncomeViewModel?) {
        customView.configure(viewModel: incomeViewModel)
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
