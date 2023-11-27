//
//  EmptyView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class EmptyView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "there is nothing yet"
        label.font = label.font.withSize(.big)
        return label
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyView: UIViewCode {
    
    // MARK: - View Setup
    
    func setupView() { }
    
    func setupHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
