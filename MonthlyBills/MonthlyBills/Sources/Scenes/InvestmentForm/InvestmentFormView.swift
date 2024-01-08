//
//  InvestmentFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 04/01/24.
//

import Core
import SharpnezDesignSystem
import UIKit
import SnapKit

final class InvestmentFormView: UIView {
    
    // MARK: UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: Constants.Form.title, CoreConstants.Commons.investmentsKey.lowercased())
        label.font = .systemFont(ofSize: .big, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .medium
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var notesField: UINotesView = {
        let notesView = UINotesView(title: String(format: Constants.Form.notes, CoreConstants.Commons.investmentsKey))
        return notesView
    }()
    
    private lazy var sharesTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.sharesKey)
        return textfield
    }()
    
    private lazy var privatePensionTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.privatePensionKey)
        return textfield
    }()
    
    private lazy var fixedIncomeTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.fixedIncomeKey)
        return textfield
    }()
    
    private lazy var otherTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.otherKey)
        return textfield
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
    
    func configure(notes: String, viewModel: InvestmentViewModel?) {
        notesField.textView.text = notes
        sharesTextField.textField.text = viewModel?.shares.toCurrency()
        privatePensionTextField.textField.text = viewModel?.privatePension.toCurrency()
        fixedIncomeTextField.textField.text = viewModel?.fixedIncome.toCurrency()
        otherTextField.textField.text = viewModel?.other.toCurrency()
    }
    
    func buildViewModel() -> InvestmentViewModel {
        return InvestmentViewModel(
            shares: sharesTextField.textField.text?.currencyToDouble ?? .zero,
            privatePension: privatePensionTextField.textField.text?.currencyToDouble ?? .zero,
            fixedIncome: fixedIncomeTextField.textField.text?.currencyToDouble ?? .zero,
            other: otherTextField.textField.text?.currencyToDouble ?? .zero
        )
    }
    
    func buildNotes() -> String {
        return notesField.textView.text
    }
}

extension InvestmentFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(notesField)
        fieldsStackView.addArrangedSubview(sharesTextField)
        fieldsStackView.addArrangedSubview(privatePensionTextField)
        fieldsStackView.addArrangedSubview(fixedIncomeTextField)
        fieldsStackView.addArrangedSubview(otherTextField)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(CGFloat.deviceWidth)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(CGFloat.small)
            $0.width.equalTo(CGFloat.deviceWidth - CGFloat.xxBig)
        }
        
        fieldsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.medium)
            $0.horizontalEdges.bottom.equalToSuperview().inset(CGFloat.small)
        }
    }
}

extension InvestmentFormView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != .zero {
            scrollView.contentOffset.x = .zero
        }
    }
}
