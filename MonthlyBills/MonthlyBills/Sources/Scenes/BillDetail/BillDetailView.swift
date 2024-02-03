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
    
    var delegate: BillDetailViewControllerDelegate?
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
    
    private lazy var totalPayedView: FCTotalView = {
        let view = FCTotalView(title: "Total payed", value: "00,00")
        return view
    }()
    
    private lazy var totalPendingView: FCTotalView = {
        let view = FCTotalView(title: "Total pending", value: "00,00")
        return view
    }()
    
    private lazy var totalView: FCTotalView = {
        let view = FCTotalView(title: "Total", value: "00,00")
        return view
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
        totalPayedView.valueText = delegate?.getBill()?.payedBalance.toCurrency()
        totalPendingView.valueText = delegate?.getBill()?.pendingBalance.toCurrency()
        totalView.valueText = delegate?.getBill()?.balance.toCurrency()
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
        addSubview(totalPayedView)
        addSubview(totalPendingView)
        addSubview(totalView)
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
        
        totalPayedView.snp.makeConstraints {
            $0.top.equalTo(self.separatorView.snp.bottom).offset(CGFloat.extraSmall)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.xBig)
        }
        
        totalPendingView.snp.makeConstraints {
            $0.top.equalTo(self.totalPayedView.snp.bottom).offset(CGFloat.extraSmall)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.xBig)
        }
        
        totalView.snp.makeConstraints {
            $0.top.equalTo(self.totalPendingView.snp.bottom).offset(CGFloat.extraSmall)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.xBig)
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
