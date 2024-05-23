//
//  LoginFaceIDView.swift
//  Login
//
//  Created by Tiago Linhares on 20/05/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class LoginFaceIDView: UIView {
    
    // MARK: Properties
    
    var onAccess: (() -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FaceID and iPhone's password"
        label.font = .systemFont(ofSize: .big, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "To access your account you must do it with yor FaceID and iPhone's password."
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var faceIDButton: UISHButton = {
        let button = UISHButton(
            text: "Access",
            style: .init(
                type: .primary,
                mainColor: .blue,
                alternativeColor: .white,
                font: .body(.montserrat, .regular)
            ),
            action: .init(handler: { [weak self] _ in
                self?.onAccess?()
            })
        )
        return button
    }()
    
    // MARK: Init
    
    init(onAccess: (() -> Void)?) {
        self.onAccess = onAccess
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension LoginFaceIDView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(faceIDButton)
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
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.big)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(CGFloat.big)
        }
    }
}
