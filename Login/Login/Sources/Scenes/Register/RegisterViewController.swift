//
//  
//  RegisterViewController.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol RegisterViewControlling {
    // TODO: protocol code
}

final class RegisterViewController: UIVIPBaseViewController<RegisterView, RegisterInteracting, RegisterRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = "Register"
    }
}

extension RegisterViewController: RegisterViewControlling {
    
    // MARK: Controller Input
    
    // TODO: controller code
}
