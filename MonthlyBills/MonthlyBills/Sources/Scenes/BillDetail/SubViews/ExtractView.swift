//
//  ExtractView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//

import Core
import SharpnezDesignSystem
import SnapKit
import UIKit

final class ExtractView: UIView {
    
    // MARK: Properties
    
    var didTapEdit: (() -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: .big, weight: .semibold)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.didTapEdit?()
        }
        var configuration = UIButton.Configuration.plain()
        configuration.title = CoreConstants.Commons.edit
        let button = UIButton(configuration: configuration, primaryAction: action)
        return button
    }()
    
    private lazy var rowsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .extraSmall
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Configure
    
    func configure(viewModel: ExtractViewModel) {
        titleLabel.text = viewModel.title
        rowsStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        viewModel.rows.forEach { row in
            let keyLabel = UILabel()
            keyLabel.text = String(format: CoreConstants.Commons.key, row.title)
            
            let valueLabel = UILabel()
            valueLabel.text = row.value
            
            if row.title == CoreConstants.Commons.total || row.title == CoreConstants.Commons.percentage {
                keyLabel.font = .systemFont(ofSize: .medium, weight: .medium)
                valueLabel.font = .systemFont(ofSize: .medium, weight: .medium)
            }
            
            let stackView = getStackView()
            stackView.addArrangedSubview(keyLabel)
            stackView.addArrangedSubview(valueLabel)
            
            rowsStackView.addArrangedSubview(stackView)
        }
    }
    
    func getStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }
}

extension ExtractView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(rowsStackView)
        addSubview(editButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(CGFloat.extraSmall)
            $0.trailing.equalToSuperview()
        }
        
        rowsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.small)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
