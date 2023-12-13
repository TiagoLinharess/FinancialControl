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
    func presentSuccess(incomeViewModel: IncomeViewModel?)
    func presentError(message: String)
}

final class IncomeFormViewController: UIVIPBaseViewController<IncomeFormView, IncomeFormInteracting, IncomeFormRouting> {
    
    // MARK: Properties
    
    private let monthId: String
    private var incomeViewModel: IncomeViewModel?
    
    // MARK: Init
    
    init(
        monthId: String,
        customView: IncomeFormView,
        interactor: IncomeFormInteracting,
        router: IncomeFormRouting
    ) {
        self.monthId = monthId
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.incomesKey
    }
}

extension IncomeFormViewController: IncomeFormViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(incomeViewModel: IncomeViewModel?) {
        self.incomeViewModel = incomeViewModel
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
