//
//  ConfigurationView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 07/06/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

protocol ConfigurationViewDelegate {
    func didSelect(configuration: Configurations)
}

final class ConfigurationView: UIView {
    
    // MARK: Properties
    
    var delegate: ConfigurationViewDelegate?
    let reuseIdentifier: String = Constants.Configurations.reuseIdentifier
    
    // MARK: UI Elements
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .clear
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
}

extension ConfigurationView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemGroupedBackground
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

extension ConfigurationView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Configurations.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = Configurations(rawValue: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = item.getName()
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = Configurations(rawValue: indexPath.row) else { return }
        delegate?.didSelect(configuration: item)
    }
}
