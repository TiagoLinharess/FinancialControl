//
//  
//  TemplateFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol TemplateFormViewControllerDelegate {
    func getTemplates() -> [BillSectionViewModel]
    func select(at item: BillItemFormType)
    func delete(at indexPath: IndexPath)
}

protocol TemplateFormViewControlling {
    func presentSuccess(templates: [BillSectionViewModel])
    func presentError(errorMessage: String)
}

final class TemplateFormViewController: UIVIPBaseViewController<TemplateFormView, TemplateFormInteracting, TemplateFormRouting> {
    
    // MARK: Properties
    
    private var templates: [BillSectionViewModel] = []
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetch()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = Constants.TemplateFormView.title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    // MARK: Actions
    
    @objc
    func didTapAddButton() {
        router.routeToItemForm(at: .template, animated: true)
    }
}

extension TemplateFormViewController: TemplateFormViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(templates: [BillSectionViewModel]) {
        self.templates = templates
        customView.configure()
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

extension TemplateFormViewController: TemplateFormViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getTemplates() -> [BillSectionViewModel] {
        return templates
    }
    
    func select(at item: BillItemFormType) {
        router.routeToItemForm(at: item, animated: true)
    }
    
    func delete(at indexPath: IndexPath) {
        interactor.delete(at: templates[indexPath.section].items[indexPath.row].id)
    }
}
