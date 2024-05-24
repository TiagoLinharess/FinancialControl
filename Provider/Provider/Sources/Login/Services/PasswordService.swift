//
//  PasswordService.swift
//  Provider
//
//  Created by Tiago Linhares on 23/05/24.
//

import Foundation
import SharpnezCore

protocol PasswordServiceProtocol {
    func makePassword(password: String) throws
}

final class PasswordService: PasswordServiceProtocol {
    
    // MARK: Properties
    
    private let passwordRepository: PasswordRepositoryProtocol
    private let sessionRepository: SessionRepositoryProtocol
    
    // MARK: Init
    
    init(
        passwordRepository: PasswordRepositoryProtocol = PasswordRepository(),
        sessionRepository: SessionRepositoryProtocol = SessionRepository()
    ) {
        self.passwordRepository = passwordRepository
        self.sessionRepository = sessionRepository
    }
    
    // MARK: Methods
    
    func makePassword(password: String) throws {
        do {
            if password.count < 4 {
                throw CoreError.customError(Constants.Login.incompletePassword)
            }
            
            let encodedPassword = Data(password.utf8).base64EncodedString()
            try passwordRepository.createPassword(password: encodedPassword)
        } catch let error as CoreError {
            try matchPassword(error: error, password: password)
        } catch {
            throw error
        }
    }
}

private extension PasswordService {
    
    // MARK: Private Methods
    
    func validatePassword(passwordAttempt: String) throws -> Bool {
        let encodedPassword = try passwordRepository.getPassword()
        
        guard let data = Data(base64Encoded: encodedPassword),
              let password = String(data: data, encoding: .utf8)
        else {
            throw CoreError.parseError
        }
        
        return passwordAttempt == password
    }
    
    func matchPassword(error: CoreError, password: String) throws {
        if error.message == Constants.Login.passwordExists {
            if try validatePassword(passwordAttempt: password) {
                try sessionRepository.createSession()
                return
            }
            throw CoreError.customError(Constants.Login.incorrectPassword)
        }
        
        throw error
    }
}
