//
//  LoginWorker.swift
//  Login
//
//  Created by Tiago Linhares on 02/05/24.
//

import Foundation
import Provider
import SharpnezCore

protocol LoginWorking {
    func verifySession() -> Bool
    func makeFaceID(onLogin: @escaping (Bool) -> Void)
}

final class LoginWorker: LoginWorking {
    
    // MARK: Properties
    
    private let provider: LoginProviderProtocol
    
    // MARK: Init
    
    init(provider: LoginProviderProtocol = LoginProvider()) {
        self.provider = provider
    }
    
    // MARK: Methods
    
    func verifySession() -> Bool {
        return provider.verifySession()
    }
    
    func makeFaceID(onLogin: @escaping (Bool) -> Void) {
        provider.makeFaceID(onLogin: onLogin)
    }
}
