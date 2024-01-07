//
//  
//  ExpenseFormFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//
//

import UIKit

enum ExpenseFormFactory {
    
    static func configure(billId: String) -> UIViewController {
        let router = ExpenseFormRouter()
        let presenter = ExpenseFormPresenter()
        let interactor = ExpenseFormInteractor(presenter: presenter)
        let view = ExpenseFormView()
        
        let controller = ExpenseFormViewController(
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
