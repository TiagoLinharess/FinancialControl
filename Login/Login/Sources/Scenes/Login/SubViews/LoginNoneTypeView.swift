//
//  LoginNoneTypeView.swift
//  Login
//
//  Created by Tiago Linhares on 20/05/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class LoginNoneTypeView: UIView {
    
    // MARK: Properties
    
    var onSelectFaceID: (() -> Void)?
    var onSelectPassword: (() -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Account access"
        label.font = .systemFont(ofSize: .big, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "To access your account you must create a password, or access with yor FaceID and iPhone's password."
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var faceIDButton: UISHButton = {
        let button = UISHButton(
            text: "FaceID",
            style: .init(
                type: .primary,
                mainColor: .blue,
                alternativeColor: .white,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.onSelectFaceID?()
            })
        )
        return button
    }()
    
    private lazy var passwordButton: UISHButton = {
        let button = UISHButton(
            text: "Create password",
            style: .init(
                type: .secondary,
                mainColor: .blue,
                alternativeColor: .clear,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.onSelectPassword?()
            })
        )
        return button
    }()
    
    // MARK: Init
    
    init(
        onSelectFaceID: (() -> Void)?,
        onSelectPassword: (() -> Void)?
    ) {
        self.onSelectFaceID = onSelectFaceID
        self.onSelectPassword = onSelectPassword
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoginNoneTypeView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(faceIDButton)
        addSubview(passwordButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        faceIDButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(CGFloat.big)
            $0.bottom.equalTo(passwordButton.snp.top).offset(-CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
        
        passwordButton.snp.makeConstraints {
            $0.top.equalTo(faceIDButton.snp.bottom).offset(CGFloat.big)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
    }
}
