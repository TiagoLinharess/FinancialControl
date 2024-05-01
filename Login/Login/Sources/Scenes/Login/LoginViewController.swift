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
    // TODO: protocol code
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
        title = "Login"
    }
}

extension LoginViewController: LoginViewControlling {
    
    // MARK: Controller Input
    
    // TODO: controller code
}

extension LoginViewController: LoginViewDelegate {
    
    // MARK: LoginViewDelegate
    
    func submit() {
        print("login")
    }
    
    func register() {
        print("register")
    }
}
