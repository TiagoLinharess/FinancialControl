//
//  AuthTypeRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 23/05/24.
//

import Foundation
import Security
import SharpnezCore

protocol AuthTypeRepositoryProtocol {
    func createAuthType(authType: AuthTypeResponse) throws
    func getAuthType() throws -> AuthTypeResponse?
}

final class AuthTypeRepository: AuthTypeRepositoryProtocol {
    
    // MARK: Create
    
    func createAuthType(authType: AuthTypeResponse) throws {
        if let data = authType.rawValue.data(using: .utf8) {
            let query = getSaveQuery(data: data)
            let status = SecItemAdd(query, nil)
            
            if status == errSecDuplicateItem {
                return
            }
            
            if status != noErr {
                throw CoreError.parseError
            }
        } else {
            throw CoreError.parseError
        }
    }
    
    // MARK: Read
    
    func getAuthType() throws -> AuthTypeResponse? {
        let query = getFetchQuery()
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == noErr {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let string = String(data: data, encoding: .utf8)
            {
                return AuthTypeResponse(rawValue: string)
            } else {
                throw CoreError.parseError
            }
        }
        
        if status == errSecItemNotFound {
            return nil
        }
        
        throw CoreError.parseError
    }
}

private extension AuthTypeRepository {
    
    // MARK: Private Methods
    
    func getSaveQuery(data: Data) -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.authTypeQueryKey,
            kSecValueData as String: data,
        ] as CFDictionary
    }
    
    func getFetchQuery() -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.authTypeQueryKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ] as CFDictionary
    }
}
