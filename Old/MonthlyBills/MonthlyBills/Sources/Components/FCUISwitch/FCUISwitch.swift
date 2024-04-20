//
//  FCUISwitch.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 23/01/24.
//

import Core
import CurrencyText
import SharpnezDesignSystem
import SnapKit
import UIKit

final class FCUISwitch: UIView {
    
    // MARK: Properties
    
    var action: () -> Void
    
    var isOn: Bool {
        get { return uiswitch.isOn }
        set { uiswitch.isOn = newValue }
    }
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var uiswitch: UISwitch = {
        let view = UISwitch(frame: .zero, primaryAction: .init(handler: { [weak self] _ in
            self?.action()
        }))
        return view
    }()
    
    // MARK: Init
    
    init(title: String, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        setup()
        titleLabel.text = title.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FCUISwitch: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(uiswitch)
    }
    
    func setupConstraints() {
        uiswitch.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(self.titleLabel.snp.leading).offset(-CGFloat.small)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.bottom.equalToSuperview()
        }
    }
}
