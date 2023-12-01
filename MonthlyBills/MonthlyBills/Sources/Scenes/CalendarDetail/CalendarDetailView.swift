//
//  CalendarDetailView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class CalendarDetailView: UIView {
    
    // MARK: Properties
    
    var delegate: CalendarDetailViewControllerDelegate?
    let reuseIdentifier: String = "CalendarDetailViewCellIdentifier"
    
    // MARK: UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
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
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension CalendarDetailView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CalendarDetailView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getCalendar().monthlyBills.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let calendar = delegate?.getCalendar() else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let monthlyBill = calendar.monthlyBills[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = monthlyBill.month
        content.secondaryText = monthlyBill.balance.toCurrency()
        content.prefersSideBySideTextAndSecondaryText = true
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectMonthlyBill(at: indexPath.row)
    }
}
