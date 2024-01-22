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
    
    /* Impements view code */
    
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
    
    private lazy var sectionPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .secondarySystemBackground
        picker.layer.cornerRadius = .smaller
        return picker
    }()
    
    private lazy var statusPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .secondarySystemBackground
        picker.layer.cornerRadius = .smaller
        return picker
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension BillItemFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(sectionPickerView)
        scrollView.addSubview(statusPickerView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sectionPickerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
            $0.height.equalTo(CoreConstants.Sizes.pickerHeight)
            $0.width.equalTo(CGFloat.deviceWidth - CGFloat.xxBig)
        }
        
        statusPickerView.snp.makeConstraints {
            $0.top.equalTo(self.sectionPickerView.snp.bottom).offset(CGFloat.medium)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
            $0.height.equalTo(CoreConstants.Sizes.pickerHeight)
            $0.width.equalTo(CGFloat.deviceWidth - CGFloat.xxBig)
        }
    }
}

extension BillItemFormView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sectionPickerView {
            return BillType.allCases.count
        } else {
            return BillStatus.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sectionPickerView {
            return BillType.allCases[row].name
        } else {
            return BillStatus.allCases[row].rawValue
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
