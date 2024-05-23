//
//  AuthTypeService.swift
//  Provider
//
//  Created by Tiago Linhares on 20/05/24.
//

import Foundation

protocol AuthTypeServiceProtocol {
    func verify() throws -> AuthTypeResponse
}

final class AuthTypeService: AuthTypeServiceProtocol {
    
    // MARK: Properties
    
    private let sessionRepository: SessionRepositoryProtocol
    
    // MARK: Init
    
    init(sessionRepository: SessionRepositoryProtocol = SessionRepository()) {
        self.sessionRepository = sessionRepository
    }
    
    // MARK: Methods
    
    func verify() throws -> AuthTypeResponse {
        if let _ = try? sessionRepository.getSession() {
            return .localAuthentication
        }
        
        return .none
    }
}
