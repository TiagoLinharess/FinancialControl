//
//  
//  IncomeFormFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//
//

import UIKit

enum IncomeFormFactory {
    
    static func configure(billId: String) -> UIViewController {
        let router = IncomeFormRouter()
        let presenter = IncomeFormPresenter()
        let interactor = IncomeFormInteractor(presenter: presenter)
        let view = IncomeFormView()
        
        let controller = IncomeFormViewController(
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
