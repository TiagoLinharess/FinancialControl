//
//  BillDetailView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//

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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Public Methods
    
    func configure() {
        tableView.reloadData()
    }
}

extension BillDetailView: UIViewCode {
    
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

extension BillDetailView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return delegate?.getBill()?.sectionTitle(at: section) ?? String()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getBill()?.numberOfRowsInSection(at: section) ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = delegate?.getBill()?.getItem(at: indexPath) else { return UITableViewCell() }
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
        guard let bill = delegate?.getBill(),
              let billType = delegate?.getBill()?.getBillType(at: indexPath.section)
        else { return }
        
        let item = bill.getItem(at: indexPath)
        delegate?.select(at: .init(itemType: billType, itemId: item.id, billId: bill.id))
    }
}

extension BillDetailView: UIScrollViewDelegate {
    
    // MARK: UIScrollView Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != .zero {
            scrollView.contentOffset.x = .zero
        }
    }
}
