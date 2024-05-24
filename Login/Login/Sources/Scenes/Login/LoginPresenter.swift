//
//  
//  LoginPresenter.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol LoginPresenting {
    func presentAuthType(authType: AuthType)
    func presentError()
    func presentFaceIDSuccess()
    func presentFaceIDError()
    func presentPasswordSuccess()
    func presentPasswordError(error: CoreError)
}

final class LoginPresenter: UIVIPPresenter<LoginViewControlling>, LoginPresenting {
    
    // MARK: Methods
    
    func presentAuthType(authType: AuthType) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentAuthType(authType: authType)
        }
    }
    
    func presentError() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentError()
        }
    }
    
    func presentFaceIDSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentFaceIDSuccess()
        }
    }
    
    func presentFaceIDError() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentRegisterPassword(message: LoginConstants.LoginPassword.errorMessage)
        }
    }
    
    func presentPasswordSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentPasswordSuccess()
        }
    }
    
    func presentPasswordError(error: CoreError) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentPasswordError(errorMessage: error.message)
        }
    }
}
