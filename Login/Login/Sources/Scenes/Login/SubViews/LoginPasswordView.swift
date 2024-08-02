//
//  LoginPasswordView.swift
//  Login
//
//  Created by Tiago Linhares on 24/05/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class LoginPasswordView: UIView {
    
    // MARK: Properties
    
    var onPassword: (() -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginConstants.LoginPassword.title
        label.font = .systemFont(ofSize: .big, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LoginConstants.LoginPassword.description
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var button: UISHButton = {
        let button = UISHButton(
            text: LoginConstants.Commons.access,
            style: .init(
                type: .primary,
                mainColor: .blue,
                alternativeColor: .white,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.onPassword?()
            })
        )
        return button
    }()
    
    // MARK: Init
    
    init(onPassword: (() -> Void)?) {
        self.onPassword = onPassword
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoginPasswordView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(button)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        button.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(CGFloat.big)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
    }
}
