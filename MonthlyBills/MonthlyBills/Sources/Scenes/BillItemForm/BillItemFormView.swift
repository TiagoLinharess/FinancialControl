//
//  BillItemFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//

import Core
import SharpnezDesignSystem
import SnapKit
import UIKit

final class BillItemFormView: UIView {
    
    // MARK: Properties
    
    var delegate: BillItemFormViewControllerDelegate? {
        didSet {
            guard let delegate else { return }
            handleType(formType: delegate.getFormType())
        }
    }
    
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
    
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(
            top: .medium,
            left: .small,
            bottom: .medium,
            right: .small
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = .medium
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var installmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .small
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var sectionPickerView: FCUIPickerView = {
        let items = BillType.allCases.map({ $0.rawValue })
        let picker = FCUIPickerView(title: Constants.BillItemFormView.billTypeTitle, items: items)
        picker.didSelect = { [weak self] value in self?.didsSelectSection(section: .init(rawValue: value))}
        return picker
    }()
    
    private lazy var statusPickerView: FCUIPickerView = {
        let items = BillStatus.allCases.map({ $0.rawValue })
        let picker = FCUIPickerView(title: Constants.BillItemFormView.paymentStatusTitle, items: items)
        return picker
    }()
    
    private lazy var nameTextField: FCUITextField = {
        let textField = FCUITextField(title: Constants.BillItemFormView.nameTitle, placeholder: Constants.BillItemFormView.namePlaceholder)
        return textField
    }()
    
    private lazy var valueSwitch: FCUISwitch = {
        let view = FCUISwitch(title: Constants.BillItemFormView.valueSwitchTitle, action: handleValueSwitch)
        return view
    }()
    
    private lazy var valueTextField: FCUICurrencyFieldView = {
        let textField = FCUICurrencyFieldView(title: Constants.BillItemFormView.valuePlaceholder)
        return textField
    }()
    
    private lazy var installmentSwitch: FCUISwitch = {
        let view = FCUISwitch(title: Constants.BillItemFormView.installmentSwitchTitle, action: handleInstallmentSwitch)
        return view
    }()
    
    private lazy var currentMonthTextField: FCUITextField = {
        let textField = FCUITextField(title: Constants.BillItemFormView.installmentCurrentTitle, placeholder: Constants.BillItemFormView.installmentCurrentPlaceholder)
        textField.keyboardType = .numberPad
        textField.isEnable = false
        return textField
    }()
    
    private lazy var maxMonthTextField: FCUITextField = {
        let textField = FCUITextField(title: Constants.BillItemFormView.installmentMaxTitle, placeholder: Constants.BillItemFormView.installmentMaxPlaceholder)
        textField.keyboardType = .numberPad
        textField.isEnable = false
        return textField
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
    
    func builViewModel() -> BillItemFormViewModel {
        var installment: BillInstallment?
        
        if let current = Int(currentMonthTextField.text ?? String()),
           let max = Int(maxMonthTextField.text ?? String())
        {
            installment = BillInstallment(current: current, max: max)
        }
        
        return BillItemFormViewModel(
            formType: delegate?.getFormType(),
            billType: BillType(rawValue: sectionPickerView.selectedItem),
            status: BillStatus(rawValue: statusPickerView.selectedItem),
            name: nameTextField.text,
            validateTemplateValue: valueSwitch.isOn,
            value: valueTextField.text?.currencyToDouble,
            validateInstallment: installmentSwitch.isOn,
            installment: installment
        )
    }
}

extension BillItemFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setup() {
        setupView()
        setupHierarchy()
        setupConstraints()
        setupKeyboard()
    }
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(sectionPickerView)
        fieldsStackView.addArrangedSubview(statusPickerView)
        fieldsStackView.addArrangedSubview(nameTextField)
        fieldsStackView.addArrangedSubview(valueSwitch)
        fieldsStackView.addArrangedSubview(valueTextField)
        fieldsStackView.addArrangedSubview(installmentSwitch)
        fieldsStackView.addArrangedSubview(installmentStackView)
        installmentStackView.addArrangedSubview(currentMonthTextField)
        installmentStackView.addArrangedSubview(maxMonthTextField)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fieldsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(CGFloat.deviceWidth)
        }
    }
}

private extension BillItemFormView {
    
    // MARK: Handle Form Type
    
    func handleType(formType: BillItemFormType) {
        switch formType {
        case .new:
            setupNewForm()
        case .edit:
            break // todo
        case .template:
            break // todo
        case .templateEdit:
            break // todo
        }
    }
    
    func setupNewForm() {
        valueSwitch.isHidden = true
        installmentSwitch.isHidden = true
        installmentStackView.isHidden = true
    }
}

private extension BillItemFormView {
    
    // MARK: Handle Switch
    
    func handleValueSwitch() {
        valueTextField.isEnable = valueSwitch.isOn
    }
    
    func handleInstallmentSwitch() {
        currentMonthTextField.isEnable = installmentSwitch.isOn
        maxMonthTextField.isEnable = installmentSwitch.isOn
    }
}

private extension BillItemFormView {
    
    // MARK: Handle Picker
    
    func didsSelectSection(section: BillType?) {
        guard let section else { return }
        installmentSwitch.isHidden = section == .income
        installmentStackView.isHidden = section == .income
    }
}

private extension BillItemFormView {
    
    // MARK: Keyboard Avoidance
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(keyboardSize.height)
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(CGFloat.zero)
        }
    }
}

extension BillItemFormView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != .zero {
            scrollView.contentOffset.x = .zero
        }
    }
}
