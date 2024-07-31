//
//  FaceIDService.swift
//  Provider
//
//  Created by Tiago Linhares on 02/05/24.
//

import Foundation
import LocalAuthentication

protocol FaceIDServiceProtocol {
    func make(onLogin: @escaping (Bool) -> Void)
}

final class FaceIDService: FaceIDServiceProtocol {
    
    // MARK: Properties
    
    private let repository: SessionRepositoryProtocol
    
    // MARK: Init
    
    init(repository: SessionRepositoryProtocol = SessionRepository()) {
        self.repository = repository
    }
    
    // MARK: Methods
    
    func make(onLogin: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: Constants.Login.reason
            ) { [weak self] success, _ in
                if success {
                    self?.validateNewSession(onLogin: onLogin)
                } else {
                    self?.passwordPhone(onLogin: onLogin)
                }
            }
        } else {
            passwordPhone(onLogin: onLogin)
        }
    }
}

private extension FaceIDService {
    
    // MARK: Private Methods
    
    func passwordPhone(onLogin: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: Constants.Login.reason
            ) { [weak self] success, _ in
                if success {
                    self?.validateNewSession(onLogin: onLogin)
                } else {
                    onLogin(false)
                }
            }
        } else {
            onLogin(false)
        }
    }
    
    func validateNewSession(onLogin: @escaping (Bool) -> Void) {
        do {
            try repository.createSession()
            onLogin(true)
        } catch {
            onLogin(false)
        }
    }
}
