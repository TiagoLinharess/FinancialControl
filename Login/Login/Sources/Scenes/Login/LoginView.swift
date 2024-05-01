//
//  LoginView.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

protocol LoginViewDelegate: AnyObject {
    func submit()
    func register()
}

final class LoginView: UIView {
    
    // MARK: Properties
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Financial Control"
        label.font = .systemFont(ofSize: .big, weight: .bold)
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: FCUITextField = {
        let textField = FCUITextField(
            title: "E-mail",
            placeholder: "example@example.com"
        )
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    private lazy var passwordTextField: FCUITextField = {
        let textField = FCUITextField(
            title: "Password",
            placeholder: "a@!#35"
        )
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var loginButton: UISHButton = {
        let button = UISHButton(
            text: "Login",
            style: .init(
                type: .secondary,
                mainColor: .blue,
                alternativeColor: .clear,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.delegate?.submit()
            })
        )
        return button
    }()
    
    private lazy var registerButton: UISHButton = {
        let button = UISHButton(
            text: "Don't have an account? Regiter here.",
            style: .init(
                type: .ghost,
                mainColor: .blue,
                alternativeColor: .clear,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.delegate?.register()
            })
        )
        return button
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoginView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.xLarge)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(loginButton.snp.bottom).offset(CGFloat.big)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
    }
}
