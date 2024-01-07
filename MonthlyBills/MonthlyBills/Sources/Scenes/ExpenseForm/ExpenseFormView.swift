//
//  ExpenseFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 06/01/24.
//

import Core
import SharpnezDesignSystem
import UIKit
import SnapKit

final class ExpenseFormView: UIView {
    
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
        label.text = "Please enter your monthly expenses in the fields below."
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
        let notesView = UINotesView(title: "NOTES FOR YOUR EXPENSES")
        return notesView
    }()
    
    private lazy var housingTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.housingKey)
        return textfield
    }()
    
    private lazy var transportTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.transportKey)
        return textfield
    }()
    
    private lazy var feedTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.feedKey)
        return textfield
    }()
    
    private lazy var healthTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.healthKey)
        return textfield
    }()
    
    private lazy var educationTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.educationKey)
        return textfield
    }()
    
    private lazy var taxesTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.taxesKey)
        return textfield
    }()
    
    private lazy var laisureTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.laisureKey)
        return textfield
    }()
    
    private lazy var clothingTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.clothingKey)
        return textfield
    }()
    
    private lazy var creditCardTextField: UICurrencyFieldView = {
        let textfield = UICurrencyFieldView(title: CoreConstants.Commons.creditCardKey)
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
    
    func configure(notes: String, viewModel: ExpenseViewModel?) {
        notesField.textView.text = notes
        housingTextField.textField.text = viewModel?.housing.toCurrency()
        transportTextField.textField.text = viewModel?.transport.toCurrency()
        feedTextField.textField.text = viewModel?.feed.toCurrency()
        healthTextField.textField.text = viewModel?.health.toCurrency()
        educationTextField.textField.text = viewModel?.education.toCurrency()
        taxesTextField.textField.text = viewModel?.taxes.toCurrency()
        laisureTextField.textField.text = viewModel?.laisure.toCurrency()
        clothingTextField.textField.text = viewModel?.clothing.toCurrency()
        creditCardTextField.textField.text = viewModel?.creditCard.toCurrency()
        otherTextField.textField.text = viewModel?.other.toCurrency()
    }
    
    func buildViewModel() -> ExpenseViewModel {
        return ExpenseViewModel(
            housing: housingTextField.textField.text?.currencyToDouble ?? .zero,
            transport: transportTextField.textField.text?.currencyToDouble ?? .zero,
            feed: feedTextField.textField.text?.currencyToDouble ?? .zero,
            health: healthTextField.textField.text?.currencyToDouble ?? .zero,
            education: educationTextField.textField.text?.currencyToDouble ?? .zero,
            taxes: taxesTextField.textField.text?.currencyToDouble ?? .zero,
            laisure: laisureTextField.textField.text?.currencyToDouble ?? .zero,
            clothing: clothingTextField.textField.text?.currencyToDouble ?? .zero,
            creditCard: creditCardTextField.textField.text?.currencyToDouble ?? .zero,
            other: otherTextField.textField.text?.currencyToDouble ?? .zero
        )
    }
    
    func buildNotes() -> String {
        return notesField.textView.text
    }
}

extension ExpenseFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(notesField)
        fieldsStackView.addArrangedSubview(housingTextField)
        fieldsStackView.addArrangedSubview(transportTextField)
        fieldsStackView.addArrangedSubview(feedTextField)
        fieldsStackView.addArrangedSubview(healthTextField)
        fieldsStackView.addArrangedSubview(educationTextField)
        fieldsStackView.addArrangedSubview(taxesTextField)
        fieldsStackView.addArrangedSubview(laisureTextField)
        fieldsStackView.addArrangedSubview(clothingTextField)
        fieldsStackView.addArrangedSubview(creditCardTextField)
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

extension ExpenseFormView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != .zero {
            scrollView.contentOffset.x = .zero
        }
    }
}
