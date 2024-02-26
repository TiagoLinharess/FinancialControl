//
//  FCUICurrencyFieldView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 13/12/23.
//

import Core
import CurrencyText
import SharpnezDesignSystem
import SnapKit
import UIKit

final class FCUICurrencyFieldView: UIView {
    
    // MARK: Properties
    
    private var currencyDelegate: CurrencyUITextFieldDelegate?
    
    var isEnable: Bool {
        get { return textField.isEnabled }
        set { handleEnable(isEnable: newValue) }
    }
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
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
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = .smaller
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = CoreConstants.Commons.currencyPlaceholder
        textField.keyboardType = .decimalPad
        textField.delegate = currencyDelegate
        
        let paddingView = UIView(frame: CGRect(x: .zero, y: .zero, width: .small, height: .zero))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    // MARK: Init
    
    init(title: String) {
        super.init(frame: .zero)
        setup()
        titleLabel.text = title.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FCUICurrencyFieldView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        currencyDelegate = CurrencyUITextFieldDelegate(formatter: .internationalDefault)
        currencyDelegate?.clearsWhenValueIsZero = true
        currencyDelegate?.passthroughDelegate = self
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(textField)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.nano)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(CGFloat.large)
        }
    }
}

private extension FCUICurrencyFieldView {
    
    // MARK: Private Methods
    
    func handleEnable(isEnable: Bool) {
        let alpha = isEnable ? 1 : 0.5
        textField.isEnabled = isEnable
        textField.alpha = alpha
        titleLabel.alpha = alpha
    }
}

extension FCUICurrencyFieldView: UITextFieldDelegate { }
