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
    func faceID()
    func password()
    func retry()
}

final class LoginView: UIView {
    
    // MARK: Properties
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: UI Elements
    
    private lazy var noneView: LoginNoneTypeView = {
        let view = LoginNoneTypeView(
            onSelectFaceID: faceID,
            onSelectPassword: password
        )
        return view
    }()
    
    private lazy var faceIDView: LoginFaceIDView = {
        let view = LoginFaceIDView(onAccess: faceID)
        return view
    }()
    
    private lazy var passwordView: LoginPasswordView = {
        let view = LoginPasswordView(onPassword: password)
        return view
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Public Methods
    
    func showAuthType(authType: AuthType) {
        switch authType {
        case .localAuthentication:
            showFaceID()
        case .password:
            showLocalPassword()
        case .none:
            showNoneType()
        }
    }
    
    func showError() {
        noneView.isHidden = true
        faceIDView.isHidden = true
        passwordView.isHidden = true
    }
}

extension LoginView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(noneView)
        addSubview(faceIDView)
        addSubview(passwordView)
    }
    
    func setupConstraints() {
        noneView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        faceIDView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        passwordView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

private extension LoginView {
    
    // MARK: Private Methods
    
    func showNoneType() {
        noneView.isHidden = false
        faceIDView.isHidden = true
        passwordView.isHidden = true
    }
    
    func showLocalPassword() {
        noneView.isHidden = true
        faceIDView.isHidden = true
        passwordView.isHidden = false
    }
    
    func showFaceID() {
        noneView.isHidden = true
        faceIDView.isHidden = false
        passwordView.isHidden = true
        delegate?.faceID()
    }
    
    func faceID() {
        delegate?.faceID()
    }
    
    func password() {
        delegate?.password()
    }
}
