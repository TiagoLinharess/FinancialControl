//
//  IncomeFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 12/12/23.
//

import Core
import SharpnezDesignSystem
import SnapKit
import UIKit

final class IncomeFormView: UIView {
    
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
        label.text = "Please enter your monthly incomes in the fields below."
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
    
    private lazy var salaryTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.salaryKey)
        return textfield
    }()
    
    private lazy var bonusTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.bonusKey)
        return textfield
    }()
    
    private lazy var extraTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.extraKey)
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
    
    func configure(viewModel: IncomeViewModel?) {
        salaryTextField.textField.text = viewModel?.salary.toCurrency()
        bonusTextField.textField.text = viewModel?.bonus.toCurrency()
        extraTextField.textField.text = viewModel?.extra.toCurrency()
        otherTextField.textField.text = viewModel?.other.toCurrency()
    }
    
    func buildViewModel() -> IncomeViewModel {
        var viewModel = IncomeViewModel()
        viewModel.salary = salaryTextField.textField.text?.currencyToDouble ?? .zero
        viewModel.bonus = bonusTextField.textField.text?.currencyToDouble ?? .zero
        viewModel.extra = extraTextField.textField.text?.currencyToDouble ?? .zero
        viewModel.other = otherTextField.textField.text?.currencyToDouble ?? .zero
        
        return viewModel
    }
}

extension IncomeFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(salaryTextField)
        fieldsStackView.addArrangedSubview(bonusTextField)
        fieldsStackView.addArrangedSubview(extraTextField)
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

extension IncomeFormView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != .zero {
            scrollView.contentOffset.x = .zero
        }
    }
}
