//
//  PasswordRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 23/05/24.
//

import Foundation
import Security
import SharpnezCore

protocol PasswordRepositoryProtocol {
    func createPassword(password: String) throws
    func getPassword() throws -> String
}

final class PasswordRepository: PasswordRepositoryProtocol {
    
    // MARK: Create
    
    func createPassword(password: String) throws {
        if let data = password.data(using: .utf8) {
            let query = getSaveQuery(data: data)
            let status = SecItemAdd(query, nil)
            
            if status == errSecDuplicateItem {
                throw CoreError.customError(Constants.Login.passwordExists)
            }
            
            if status != noErr {
                throw CoreError.parseError
            }
        } else {
            throw CoreError.parseError
        }
    }
    
    // MARK: Read
    
    func getPassword() throws -> String {
        let query = getFetchQuery()
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == noErr {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let string = String(data: data, encoding: .utf8)
            {
                return string
            } else {
                throw CoreError.parseError
            }
        }
        
        if status == errSecItemNotFound {
            throw CoreError.parseError
        }
        
        throw CoreError.parseError
    }
}

private extension PasswordRepository {
    
    // MARK: Private Methods
    
    func getSaveQuery(data: Data) -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.passwordQueryKey,
            kSecValueData as String: data,
        ] as CFDictionary
    }
    
    func getFetchQuery() -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.passwordQueryKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ] as CFDictionary
    }
}
