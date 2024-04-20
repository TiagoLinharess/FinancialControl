//
//  ErrorView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Core
import SharpnezDesignSystem
import SnapKit
import UIKit

final class ErrorView: UIView {
    
    // MARK: Properties
    
    var didTap: (() -> Void)
    
    // MARK: UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = CoreConstants.Error.generic
        label.font = label.font.withSize(.big)
        return label
    }()
    
    private lazy var button: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.didTap()
        }
        var configuration = UIButton.Configuration.filled()
        configuration.title = CoreConstants.Commons.tryAgain
        configuration.buttonSize = .large
        configuration.cornerStyle = .medium
        let button = UIButton(configuration: configuration, primaryAction: action)
        return button
    }()
    
    // MARK: Init
    
    init(didTap: @escaping () -> Void) {
        self.didTap = didTap
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(CoreConstants.Init.coder)
    }
    
    // MARK: Public Mehtods
    
    func updateText(text: String) {
        label.text = text
    }
}

extension ErrorView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() { }
    
    func setupHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(CGFloat.small)
            $0.centerX.equalToSuperview()
        }
    }
}
