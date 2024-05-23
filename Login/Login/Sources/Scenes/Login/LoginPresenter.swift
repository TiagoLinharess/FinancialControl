//
//  
//  LoginPresenter.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol LoginPresenting {
    func presentAuthType(authType: AuthType)
    func presentError()
    func faceIDSuccess()
    func faceIDError()
}

final class LoginPresenter: UIVIPPresenter<LoginViewControlling>, LoginPresenting {
    
    // MARK: Methods
    
    func presentAuthType(authType: AuthType) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentAuthType(authType: authType)
        }
    }
    
    func faceIDSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.faceIDSuccess()
        }
    }
    
    func faceIDError() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.registerPassword()
        }
    }
    
    func presentError() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.presentError()
        }
    }
}
