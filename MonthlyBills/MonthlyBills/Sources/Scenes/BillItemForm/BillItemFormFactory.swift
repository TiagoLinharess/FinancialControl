//
//  
//  BillItemFormFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import UIKit

enum BillItemFormFactory {
    
    static func configure(formType: BillItemFormType) -> UIViewController {
        let router = BillItemFormRouter()
        let presenter = BillItemFormPresenter()
        let interactor = BillItemFormInteractor(presenter: presenter)
        let view = BillItemFormView()
        
        let controller = BillItemFormViewController(
            formType: formType,
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        view.delegate = controller
        
        return controller
    }
}
