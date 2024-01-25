//
//  
//  BillItemFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol BillItemFormViewControllerDelegate {
    func getFormType() -> BillItemFormType
}

protocol BillItemFormViewControlling {
    func presentItem(viewModel: BillItemFormViewModel)
    func presentSuccess()
    func presentError(errorMessage: String)
}

final class BillItemFormViewController: UIVIPBaseViewController<BillItemFormView, BillItemFormInteracting, BillItemFormRouting> {
    
    // MARK: Properties
    
    private let formType: BillItemFormType
    
    // MARK: Init
    
    init(
        formType: BillItemFormType,
        customView: BillItemFormView,
        interactor: BillItemFormInteracting,
        router: BillItemFormRouting
    ) {
        self.formType = formType
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        interactor.configure(formType: formType)
    }
    
    // MARK: Configure
    
    private func configure() {
        title = "Item"
        let checkButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(checkAction))
        navigationItem.rightBarButtonItems = [checkButton]
    }
    
    // MARK: Actions
    
    @objc
    func checkAction() {
        let viewModel = customView.builViewModel()
        interactor.submit(viewModel: viewModel)
    }
}

extension BillItemFormViewController: BillItemFormViewControlling {
    
    // MARK: Controller Input
    
    func presentItem(viewModel: BillItemFormViewModel) {
        customView.configureItem(viewModel: viewModel)
    }
    
    func presentSuccess() {
        presentFeedbackDialog(
            with: FeedbackModel(
                title: CoreConstants.Commons.AlertTitle,
                description: CoreConstants.Commons.success,
                buttons: [.init(title: CoreConstants.Commons.ok, style: .default, handler: { [weak self] _ in
                    self?.router.close()
                })]
            )
        )
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

extension BillItemFormViewController: BillItemFormViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getFormType() -> BillItemFormType {
        return formType
    }
}
