//
//  FaceIDSessionRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 04/05/24.
//

import Foundation
import Security
import SharpnezCore

protocol SessionRepositoryProtocol {
    func createSession() throws
    func getSession() throws -> String?
}

final class SessionRepository: SessionRepositoryProtocol {
    
    // MARK: Create
    
    func createSession() throws {
        if let data = Date.formattedNowString().data(using: .utf8) {
            let query = getSaveQuery(data: data)
            let status = SecItemAdd(query, nil)
            
            if status == errSecDuplicateItem {
                try updateSession(valueData: data)
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
    
    func getSession() throws -> String? {
        let query = getFetchQuery()
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == noErr {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let stringDate = String(data: data, encoding: .utf8)
            {
                return stringDate
            } else {
                throw CoreError.parseError
            }
        }
        
        if status == errSecItemNotFound {
            return nil
        }
        
        throw CoreError.parseError
    }
    
    // MARK: Update
    
    func updateSession(valueData: Data) throws {
        let query = getUpdateQuery()
        let valueToUpdate = [kSecValueData: valueData] as CFDictionary
        
        let status = SecItemUpdate(query, valueToUpdate)
        
        if status != noErr {
            throw CoreError.parseError
        }
    }
}

private extension SessionRepository {
    
    // MARK: Private Methods
    
    func getSaveQuery(data: Data) -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.sessionQueryKey,
            kSecValueData as String: data,
        ] as CFDictionary
    }
    
    func getFetchQuery() -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.sessionQueryKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ] as CFDictionary
    }
    
    func getUpdateQuery() -> CFDictionary {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: Constants.Login.sessionQueryKey,
        ] as CFDictionary
    }
}
