//
//  FCTotalView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 31/01/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class FCTotalView: UIView {
    
    // MARK: Properties
    
    var valueText: String? {
        get { return valueLabel.text }
        set { valueLabel.text = newValue }
    }
    
    var totalText: String? {
        get { return totalLabel.text }
        set { totalLabel.text = newValue }
    }
    
    // MARK: UI Elements
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: Init
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        setup()
        totalText = title
        valueText = value
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FCTotalView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(totalLabel)
        addSubview(valueLabel)
    }
    
    func setupConstraints() {
        totalLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(self.valueLabel.snp.leading).offset(CGFloat.small)
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(self.totalLabel.snp.trailing).offset(CGFloat.small)
        }
    }
}
