//
//  BillTypeTableViewCell.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class BillTypeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier: String = Constants.BilltypesList.reuseIdentifier
    var viewModel: BillTypeViewModel?
    var onToggleSwitch: ((String) -> Void)?
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: .medium)
        return label
    }()
    
    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Is income?"
        return label
    }()
    
    private lazy var incomeSwitch: UISwitch = {
        let view = UISwitch()
        view.addAction(UIAction(handler: { [weak self] _ in
            guard let viewModel = self?.viewModel else { return }
            self?.onToggleSwitch?(viewModel.id)
        }), for: .touchUpInside)
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImage(systemName: "line.3.horizontal") ?? UIImage()
        let view = UIImageView(image: image)
        return view
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Configure
    
    func configure(viewModel: BillTypeViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.name
        incomeSwitch.isOn = viewModel.isIncome
    }
    
    func toggleSwitch() {
        incomeSwitch.isOn.toggle()
    }
}

extension BillTypeTableViewCell: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        isUserInteractionEnabled = true
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchLabel)
        contentView.addSubview(incomeSwitch)
        contentView.addSubview(icon)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        switchLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.nano)
            $0.trailing.equalTo(incomeSwitch.snp.leading).offset(-CGFloat.extraSmall)
            $0.leading.bottom.equalToSuperview().inset(CGFloat.small)
        }
        
        incomeSwitch.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.nano)
            $0.leading.equalTo(switchLabel.snp.trailing).offset(CGFloat.extraSmall)
            $0.bottom.equalToSuperview().inset(CGFloat.small)
        }
        
        icon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(CGFloat.small)
        }
    }
}
