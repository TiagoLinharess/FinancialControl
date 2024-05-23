//
//  Constants.swift
//  Login
//
//  Created by Tiago Linhares on 23/05/24.
//

import Foundation

enum LoginConstants {
    
    enum Commons {
        
        // MARK: Commons
        
        static let login: String = "Login"
        static let localAuth: String = "FaceID and iPhone's password"
        static let access: String = "Access"
        static let error: String = "Error"
        static let errorDescription: String = "An error has occurred"
        static let tryAgain: String = "Try Again"
    }
    
    enum LoginNoneType {
        
        // MARK: LoginNoneType
        
        static let title: String = "Account access"
        static let description: String = "To access your account you must create a password, or access with yor FaceID and iPhone's password."
        static let createPassword: String = "Create password"
    }
    
    enum LoginFaceID {
        
        // MARK: LoginFaceID
        
        static let description: String = "To access your account you must do it with yor FaceID and iPhone's password."
    }
}
