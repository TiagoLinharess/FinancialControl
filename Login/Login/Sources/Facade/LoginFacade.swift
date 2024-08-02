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
        if hasSession() {
            return
        }
        
        let viewModel = LocalSessionViewModel()
        let controller = LocalSessionHostingController(rootView: .init(viewModel: viewModel))
        controller.modalPresentationStyle = .overFullScreen
        viewModel.onClose = close
        
        navigationController.present(controller, animated: true)
    }
}

private extension LoginFacade {
    
    // MARK: Private Methods
    
    func close(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController.dismiss(animated: animated)
        }
    }
    
    func hasSession() -> Bool {
        return worker.verifySession()
    }
}
