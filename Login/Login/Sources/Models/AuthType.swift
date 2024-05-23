//
//  AuthType.swift
//  Login
//
//  Created by Tiago Linhares on 12/05/24.
//

import Foundation
import Provider

enum AuthType {
    case localAuthentication
    case password
    case none
    
    init(response: AuthTypeResponse) {
        switch response {
        case .localAuthentication:
            self = .localAuthentication
        case .password:
            self = .password
        case .none:
            self = .none
        }
    }
}
