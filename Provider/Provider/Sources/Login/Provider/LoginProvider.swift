//
//  LoginProvider.swift
//  Provider
//
//  Created by Tiago Linhares on 02/05/24.
//

import Foundation

public protocol LoginProviderProtocol {
    func verifySessionType() throws -> AuthTypeResponse
    func verifySession() -> Bool
    func makeFaceID(onLogin: @escaping (Bool) -> Void)
    func makeCustomPassword(password: String) throws
}

public final class LoginProvider: LoginProviderProtocol {
    
    // MARK: Properties
    
    private let authTypeService: AuthTypeServiceProtocol
    private let sessionService: SessionServiceProtocol
    private let faceIDService: FaceIDServiceProtocol
    private let passwordService: PasswordServiceProtocol
    
    // MARK: Init
    
    init(
        faceIDService: FaceIDServiceProtocol,
        authTypeService: AuthTypeServiceProtocol,
        sessionService: SessionServiceProtocol,
        passwordService: PasswordServiceProtocol
    ) {
        self.faceIDService = faceIDService
        self.authTypeService = authTypeService
        self.sessionService = sessionService
        self.passwordService = passwordService
    }
    
    public init() {
        self.authTypeService = AuthTypeService()
        self.faceIDService = FaceIDService()
        self.sessionService = SessionService()
        self.passwordService = PasswordService()
    }
    
    // MARK: Methods
    
    public func verifySessionType() throws -> AuthTypeResponse {
        return try authTypeService.verify()
    }
    
    public func verifySession() -> Bool {
        guard let session = try? sessionService.verify() else {
            return false
        }
        
        return session
    }
    
    public func makeFaceID(onLogin: @escaping (Bool) -> Void) {
        try? authTypeService.save(authType: .localAuthentication)
        faceIDService.make(onLogin: onLogin)
    }
    
    public func makeCustomPassword(password: String) throws {
        try? authTypeService.save(authType: .password)
        try passwordService.makePassword(password: password)
    }
}
