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
    func loginSuccess(animated: Bool)
    func routeToRegister(animated: Bool)
}

final class LoginRouter: UIVIPRouter, LoginRouting {
    
    // MARK: Methods
    
    func loginSuccess(animated: Bool) {
        viewController?.navigationController?.dismiss(animated: animated)
    }
    
    func routeToRegister(animated: Bool) {
        //
    }
}
