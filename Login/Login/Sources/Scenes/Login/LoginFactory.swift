//
//  
//  LoginFactory.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import UIKit

enum LoginFactory {
    
    static func configure() -> UIViewController {
        let router = LoginRouter()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        let view = LoginView()
        
        let controller = LoginViewController(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.viewController = controller
        presenter.viewController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
