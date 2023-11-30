//
//  HomeView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Core
import SharpnezCore
import SharpnezDesignSystem
import SnapKit
import UIKit

final class HomeView: UIView {
    
    // MARK: Properties
    
    var onActionError: (() -> Void)?
    var calendars: [AnnualCalendarViewModel]?
    let reuseIdentifier: String = Constants.HomeView.cellReuseIdentifier
    
    // MARK: UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView { [weak self] in
            self?.onActionError?()
        }
        view.isHidden = true
        return view
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
    
    func presentSuccess(calendars: [AnnualCalendarViewModel]) {
        self.calendars = calendars
        tableView.isHidden = false
        emptyView.isHidden = true
        errorView.isHidden = true
        tableView.reloadData()
    }
    
    func presentError(message: String?) {
        self.calendars = []
        tableView.isHidden = true
        emptyView.isHidden = true
        errorView.isHidden = false
        tableView.reloadData()
        
        if let message {
            errorView.updateText(text: message)
        }
    }
    
    func presentEmpty() {
        self.calendars = []
        tableView.isHidden = true
        emptyView.isHidden = false
        errorView.isHidden = true
        tableView.reloadData()
    }
}

extension HomeView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(emptyView)
        addSubview(errorView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        emptyView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendars?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let calendars else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        let calendar = calendars[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = calendar.year
        content.secondaryText = calendar.balance.toCurrency()
        content.prefersSideBySideTextAndSecondaryText = true
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}
