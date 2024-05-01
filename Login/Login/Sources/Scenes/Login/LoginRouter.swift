//
//  
//  LoginRouter.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol LoginRouting {
    func routeToRegister(animated: Bool)
}

final class LoginRouter: UIVIPRouter, LoginRouting {
    
    // MARK: Methods
    
    func routeToRegister(animated: Bool) {
        let controller = RegisterFactory.configure()
        viewController?.navigationController?.pushViewController(controller, animated: animated)
    }
}
