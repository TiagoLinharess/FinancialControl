//
//  AddAnnualBillView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Core
import SharpnezCore
import SharpnezDesignSystem
import SnapKit
import UIKit

final class AddAnnualBillView: UIView {
    
    // MARK: - Properties
    
    var years: [String] = []
    
    // MARK: - UI Elements
    
    private lazy var yearTextField: UITextField = {
        let textField = UITextField()
        textField.inputView = pickerView
        textField.text = "select"
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    // MARK: - Init
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setYears(years: [String]) {
        self.years = years
        pickerView.reloadAllComponents()
    }
}

extension AddAnnualBillView: UIViewCode {
    
    // MARK: - View Setup
    
    func setupView() {
        backgroundColor = .secondarySystemBackground
    }
    
    func setupHierarchy() {
        addSubview(yearTextField)
    }
    
    func setupConstraints() {
        yearTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(CGFloat.small)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
    }
}

extension AddAnnualBillView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearTextField.text = years[row]
    }
}
