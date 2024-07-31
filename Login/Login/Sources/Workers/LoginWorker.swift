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
    func verifySessionType() throws -> AuthType
    func verifySession() -> Bool
    func makeFaceID(onLogin: @escaping (Bool) -> Void)
    func makeCustomPassword(password: String) throws
}

final class LoginWorker: LoginWorking {
    
    // MARK: Properties
    
    private let provider: LoginProviderProtocol
    
    // MARK: Init
    
    init(provider: LoginProviderProtocol = LoginProvider()) {
        self.provider = provider
    }
    
    // MARK: Methods
    
    func verifySessionType() throws -> AuthType {
        return AuthType(response: try provider.verifySessionType())
    }
    
    func verifySession() -> Bool {
        return provider.verifySession()
    }
    
    func makeFaceID(onLogin: @escaping (Bool) -> Void) {
        provider.makeFaceID(onLogin: onLogin)
    }
    
    func makeCustomPassword(password: String) throws {
        try provider.makeCustomPassword(password: password)
    }
}
