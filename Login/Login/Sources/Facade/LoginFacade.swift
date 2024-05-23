//
//  LoginFacade.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//

import Foundation
import UIKit

public final class LoginFacade {
    
    // MARK: Properties
    
    private let navigationController: UINavigationController
    private let worker: LoginWorking
    
    // MARK: Init
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.worker = LoginWorker()
    }
    
    // MARK: Start
    
    public func start() {
        if verifySession() {
            return
        }
        
        let controller = LoginFactory.configure()
        controller.modalPresentationStyle = .overFullScreen
        navigationController.present(controller, animated: true)
    }
}

private extension LoginFacade {
    
    // MARK: Private Methods
    
    func verifySession() -> Bool {
        return worker.verifySession()
    }
}
