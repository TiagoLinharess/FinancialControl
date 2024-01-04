//
//  AddAnnualCalendarView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Core
import SharpnezCore
import SharpnezDesignSystem
import SnapKit
import UIKit

final class AddAnnualCalendarView: UIView {
    
    // MARK: Properties
    
    var years: [String] = []
    
    // MARK: UI Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = Constants.AddAnnualCalendarView.mainLabel
        label.font = .systemFont(ofSize: .big, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .secondarySystemBackground
        picker.layer.cornerRadius = .smaller
        return picker
    }()
    
    // MARK: Init
    
    required init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(CoreConstants.Init.coder)
    }
    
    // MARK: Public Methods
    
    func setYears(years: [String]) {
        self.years = years
        pickerView.reloadAllComponents()
    }
    
    func getSelectedYear() -> String {
        return years[pickerView.selectedRow(inComponent: .zero)]
    }
}

extension AddAnnualCalendarView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(label)
        addSubview(pickerView)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(CGFloat.small)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(self.label.snp.bottom).offset(CGFloat.xBig)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
            $0.height.equalTo(CoreConstants.Sizes.pickerHeight)
        }
    }
}

extension AddAnnualCalendarView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
}
