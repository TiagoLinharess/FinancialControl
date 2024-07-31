//
//  
//  TemplateFormFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//
//

import UIKit

enum TemplateFormFactory {
    
    static func configure() -> UIViewController {
        let router = TemplateFormRouter()
        let presenter = TemplateFormPresenter()
        let interactor = TemplateFormInteractor(presenter: presenter)
        let view = TemplateFormView()
        
        let controller = TemplateFormViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        view.delegate = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
