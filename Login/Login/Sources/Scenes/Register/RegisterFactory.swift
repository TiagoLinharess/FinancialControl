//
//  
//  RegisterFactory.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import UIKit

enum RegisterFactory {
    
    static func configure() -> UIViewController {
        let router = RegisterRouter()
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor(presenter: presenter)
        let view = RegisterView()
        
        let controller = RegisterViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
