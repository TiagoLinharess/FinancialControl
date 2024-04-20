//
//  FCUIPickerView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 22/01/24.
//

import Core
import CurrencyText
import SharpnezDesignSystem
import SnapKit
import UIKit

final class FCUIPickerView: UIView {
    
    // MARK: Properties
    
    var items: [String] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedItem: String {
        return items[pickerView.selectedRow(inComponent: .zero)]
    }
    
    var didSelect: ((String) -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
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
    
    init(title: String, items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setup()
        titleLabel.text = title.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FCUIPickerView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(pickerView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.nano)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(CoreConstants.Sizes.pickerHeight)
        }
    }
    
    // MARK: Public Methods
    
    func select(item: String?) {
        guard let item, let index = items.firstIndex(of: item) else { return }
        pickerView.selectRow(index, inComponent: .zero, animated: true)
    }
}

extension FCUIPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerView Delegate & DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelect?(items[row])
    }
}

