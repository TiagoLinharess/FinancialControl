//
//  LoginProvider.swift
//  Provider
//
//  Created by Tiago Linhares on 02/05/24.
//

import Foundation

public protocol LoginProviderProtocol {
    func verifySession() -> Bool
    func makeFaceID(onLogin: @escaping (Bool) -> Void)
}

public final class LoginProvider: LoginProviderProtocol {
    
    // MARK: Properties
    
    private let sessionService: SessionServiceProtocol
    private let faceIDService: FaceIDServiceProtocol
    
    // MARK: Init
    
    init(
        faceIDService: FaceIDServiceProtocol,
        sessionService: SessionServiceProtocol
    ) {
        self.faceIDService = faceIDService
        self.sessionService = sessionService
    }
    
    public init() {
        self.faceIDService = FaceIDService()
        self.sessionService = SessionService()
    }
    
    // MARK: Methods
    
    public func verifySession() -> Bool {
        guard let session = try? sessionService.verify() else {
            return false
        }
        
        return session
    }
    
    public func makeFaceID(onLogin: @escaping (Bool) -> Void) {
        faceIDService.make(onLogin: onLogin)
    }
}
