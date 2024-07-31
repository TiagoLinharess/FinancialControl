//
//  AuthTypeService.swift
//  Provider
//
//  Created by Tiago Linhares on 20/05/24.
//

import Foundation

protocol AuthTypeServiceProtocol {
    func save(authType: AuthTypeResponse) throws
    func verify() throws -> AuthTypeResponse
}

final class AuthTypeService: AuthTypeServiceProtocol {
    
    // MARK: Properties
    
    private let authTypeRepository: AuthTypeRepositoryProtocol
    
    // MARK: Init
    
    init(
        authTypeRepository: AuthTypeRepositoryProtocol = AuthTypeRepository()
    ) {
        self.authTypeRepository = authTypeRepository
    }
    
    // MARK: Methods
    
    func save(authType: AuthTypeResponse) throws {
        try authTypeRepository.createAuthType(authType: authType)
    }
    
    func verify() throws -> AuthTypeResponse {
        return try authTypeRepository.getAuthType() ?? .none
    }
}
