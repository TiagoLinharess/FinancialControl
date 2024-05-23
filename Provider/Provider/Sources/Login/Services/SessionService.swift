//
//  SessionService.swift
//  Provider
//
//  Created by Tiago Linhares on 23/05/24.
//

import Foundation
import SharpnezCore

protocol SessionServiceProtocol {
    func verify() throws -> Bool
}

final class SessionService: SessionServiceProtocol {
    
    // MARK: Properties
    
    private let sessionRepository: SessionRepositoryProtocol
    
    // MARK: Init
    
    init(sessionRepository: SessionRepositoryProtocol = SessionRepository()) {
        self.sessionRepository = sessionRepository
    }
    
    // MARK: Methods
    
    func verify() throws -> Bool {
        guard let date = try sessionRepository.getSession()?.toFormattedDate() else {
            return false
        }
        
        let dateNow = Date.now
        let calendar = Calendar.current.dateComponents([.minute, .hour, .day], from: date, to: dateNow)

        let day = calendar.day ?? .zero
        let hour = calendar.hour ?? .zero
        let minute = calendar.minute ?? .zero
        if day > .zero || hour > .zero || minute > 15 {
            return false
        }
        
        return true
    }
}


