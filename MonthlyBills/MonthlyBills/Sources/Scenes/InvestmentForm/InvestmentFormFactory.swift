//
//  
//  InvestmentFormFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//
//

import UIKit

enum InvestmentFormFactory {
    
    static func configure(billId: String) -> UIViewController {
        let router = InvestmentFormRouter()
        let presenter = InvestmentFormPresenter()
        let interactor = InvestmentFormInteractor(presenter: presenter)
        let view = InvestmentFormView()
        
        let controller = InvestmentFormViewController(
            billId: billId,
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
