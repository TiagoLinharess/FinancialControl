//
//  BillDetailView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//

import Core
import SharpnezDesignSystem
import SnapKit
import UIKit

final class BillDetailView: UIView {
    
    // MARK: Properties
    
    var delegate: BillDetailViewControllerDelegate? {
        didSet {
            configure()
        }
    }

    let reuseIdentifier: String = Constants.BillDetailView.reuseIdentifier
    
    // MARK: UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = CoreConstants.Commons.total
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        return label
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
    
    func configure() {
        tableView.reloadData()
        valueLabel.text = delegate?.getBill()?.balance.toCurrency()
    }
}

extension BillDetailView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(separatorView)
        addSubview(totalLabel)
        addSubview(valueLabel)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(self.tableView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
            $0.height.equalTo(CGFloat.one)
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(self.separatorView.snp.bottom).offset(CGFloat.medium)
            $0.leading.equalToSuperview().inset(CGFloat.xBig)
            $0.trailing.lessThanOrEqualTo(self.valueLabel.snp.leading).offset(CGFloat.small)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(CGFloat.medium)
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(self.separatorView.snp.bottom).offset(CGFloat.medium)
            $0.trailing.equalToSuperview().inset(CGFloat.xBig)
            $0.leading.greaterThanOrEqualTo(self.totalLabel.snp.trailing).offset(CGFloat.small)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(CGFloat.medium)
        }
    }
}

extension BillDetailView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.getBill()?.sections.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return delegate?.getBill()?.sections[section].title ?? String()
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return delegate?.getBill()?.sectionFooter(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getBill()?.sections[section].items.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bill = delegate?.getBill() else { return UITableViewCell() }
        let item = bill.sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = item.getName()
        content.secondaryText = item.getValue()
        content.prefersSideBySideTextAndSecondaryText = true
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bill = delegate?.getBill() else { return }
        
        let item = bill.sections[indexPath.section].items[indexPath.row]
        let sectionType = bill.sections[indexPath.section].type
        delegate?.select(at: .edit(bill.id, item.id, sectionType))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.delete(at: indexPath)
        }
    }
}
