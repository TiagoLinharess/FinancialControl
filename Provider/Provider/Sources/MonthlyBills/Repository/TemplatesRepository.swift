//
//  TemplatesRepository.swift
//  Provider
//
//  Created by Tiago Linhares on 14/03/24.
//

import CoreData
import Foundation
import SharpnezCore

protocol TemplatesRepositoryProtocol {
    func create(templates: [BillSectionResponse]) throws
    func read() throws -> [BillSectionResponse]
}

final class TemplatesRepository: TemplatesRepositoryProtocol {
    
    // MARK: Properties
    
    private let templateKey: String
    
    init(templateKey: String? = nil) {
        self.templateKey = templateKey ?? Constants.UserDefaultsKeys.billsTemplate
    }
    
    // MARK: Create
    
    func create(templates: [BillSectionResponse]) throws {
        let data = try JSONEncoder().encode(templates)
        UserDefaults.standard.set(data, forKey: templateKey)
    }
    
    // MARK: Read
    
    func read() throws -> [BillSectionResponse] {
        guard let data = UserDefaults.standard.data(forKey: templateKey) else { return [] }
        let response = try JSONDecoder().decode([BillSectionResponse].self, from: data)
        return response
    }
}
