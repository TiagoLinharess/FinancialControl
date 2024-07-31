//
//  
//  LoginViewController.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import SharpnezCore
import SharpnezDesignSystem
import UIKit

protocol LoginViewControlling {
    func presentAuthType(authType: AuthType)
    func presentError()
    func presentFaceIDSuccess()
    func presentRegisterPassword(message: String)
    func presentPasswordSuccess()
    func presentPasswordError(errorMessage: String)
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
    
    func presentError() {
        customView.showError()
        presentErrorAlert()
    }
    
    func presentFaceIDSuccess() {
        router.loginSuccess(animated: true)
    }
    
    func presentRegisterPassword(message: String) {
        presentPasswordAlert(message: message)
    }
    
    func presentPasswordSuccess() {
        router.loginSuccess(animated: true)
    }
    
    func presentPasswordError(errorMessage: String) {
        presentErrorAlert(message: errorMessage)
    }
}

extension LoginViewController: LoginViewDelegate {
    
    // MARK: LoginViewDelegate
    
    func faceID() {
        interactor.useFaceID()
    }
    
    func password() {
        presentRegisterPassword(message: LoginConstants.LoginPassword.message)
    }
    
    func retry() {
        interactor.verifyAuthSelection()
    }
}

private extension LoginViewController {
    
    // MARK: Private Methods
    
    func presentPasswordAlert(message: String) {
        let alertController = UIAlertController(
            title: LoginConstants.LoginPassword.title,
            message: message,
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(
            title: LoginConstants.Commons.save,
            style: .default
        ) { [weak self] _ in
            let password = (alertController.textFields?.first as? UITextField)?.text ?? String()
            self?.interactor.usePassword(password: password)
            self?.presentedViewController?.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(
            title: LoginConstants.Commons.cancel,
            style: .destructive
        ) { [weak self] _ in
            self?.presentedViewController?.dismiss(animated: true)
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = LoginConstants.LoginPassword.message
            textField.keyboardType = .numberPad
            textField.isSecureTextEntry = true
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    func presentErrorAlert(message: String = LoginConstants.Commons.errorDescription) {
        presentFeedbackDialog(
            with: FeedbackModel(
                title: LoginConstants.Commons.error,
                description: message,
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
