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
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .systemBackground
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
        backgroundColor = .systemGroupedBackground
    }
    
    func setupHierarchy() {
        addSubview(pickerView)
    }
    
    func setupConstraints() {
        pickerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(CGFloat.small)
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
