//
//  
//  LoginViewController.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol LoginViewControlling {
    func presentAuthType(authType: AuthType)
    func presentError()
    func faceIDSuccess()
    func registerPassword()
}

final class LoginViewController: UIVIPBaseViewController<LoginView, LoginInteracting, LoginRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func loadView() {
        super.loadView()
        customView.delegate = self
    }
    
    // MARK: Configure
    
    private func configure() {
        title = LoginConstants.Commons.login
        interactor.verifyAuthSelection()
    }
}

extension LoginViewController: LoginViewControlling {
    
    // MARK: Controller Input
    
    func presentAuthType(authType: AuthType) {
        customView.showAuthType(authType: authType)
    }
    
    func faceIDSuccess() {
        router.loginSuccess(animated: true)
    }
    
    func registerPassword() {
        // TODO: Avisar que vai direcionar pra senha custom
        password()
    }
    
    func presentError() {
        customView.showError()
        presentFeedbackDialog(
            with: FeedbackModel(
                title: LoginConstants.Commons.error,
                description: LoginConstants.Commons.errorDescription,
                buttons: [
                    UIAlertAction(
                        title: LoginConstants.Commons.tryAgain,
                        style: .default,
                        handler: { [weak self] _ in
                            self?.interactor.verifyAuthSelection()
                        }
                    )
                ]
            )
        )
    }
}

extension LoginViewController: LoginViewDelegate {
    
    // MARK: LoginViewDelegate
    
    func faceID() {
        interactor.useFaceID()
    }
    
    func password() {
        
    }
    
    func retry() {
        interactor.verifyAuthSelection()
    }
}
