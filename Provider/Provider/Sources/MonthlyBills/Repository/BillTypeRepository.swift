//
//  BillTypeRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 08/06/24.
//

import Foundation
import SharpnezCore

protocol BillTypeRepositoryProtocol {
    func create(items: [BillTypeResponse]) throws
    func read() throws -> [BillTypeResponse]
}

final class BillTypeRepository: BillTypeRepositoryProtocol {
    
    // MARK: Properties
    
    private let key: String
    
    init(key: String? = nil) {
        self.key = key ?? Constants.UserDefaultsKeys.billType
    }
    
    // MARK: Create
    
    func create(items: [BillTypeResponse]) throws {
        let data = try JSONEncoder().encode(items)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Read
    
    func read() throws -> [BillTypeResponse] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        let response = try JSONDecoder().decode([BillTypeResponse].self, from: data)
        return response
    }
}
