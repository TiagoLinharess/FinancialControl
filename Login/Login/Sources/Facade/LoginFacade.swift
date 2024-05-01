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
    
    // MARK: Init
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Start
    
    public func start(completion: @escaping (Result<Void, Error>) -> Void) {
        let controller = LoginFactory.configure()
        controller.modalPresentationStyle = .overFullScreen
        navigationController.present(controller, animated: true)
    }
}
