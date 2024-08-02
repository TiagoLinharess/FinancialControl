//
//  
//  ConfigurationFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 07/06/24.
//
//

import UIKit

enum ConfigurationFactory {
    
    static func configure() -> UIViewController {
        let router = ConfigurationRouter()
        let presenter = ConfigurationPresenter()
        let interactor = ConfigurationInteractor(presenter: presenter)
        let view = ConfigurationView()
        
        let controller = ConfigurationViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        view.delegate = controller
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
