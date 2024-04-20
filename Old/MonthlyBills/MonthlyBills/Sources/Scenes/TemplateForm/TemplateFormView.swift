//
//  TemplateFormView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 02/02/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

final class TemplateFormView: UIView {
    
    // MARK: Properties
    
    var delegate: TemplateFormViewControllerDelegate?
    let reuseIdentifier: String = Constants.TemplateFormView.reuseIdentifier
    
    // MARK: UI Elements
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TemplateFormView.subTitle
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.TemplateFormView.description
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = .zero
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
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
    
    func configure() {
        tableView.reloadData()
    }
}

extension TemplateFormView: UIViewCode {
    
    // MARK: View Setup
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(CGFloat.smaller)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.extraSmall)
            $0.horizontalEdges.equalToSuperview().inset(CGFloat.small)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(CGFloat.extraSmall)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension TemplateFormView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableview Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.getTemplates().count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return delegate?.getTemplates()[section].type.name ?? String()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getTemplates()[section].items.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let templates = delegate?.getTemplates() else { return UITableViewCell() }
        let item = templates[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = item.getName()
        content.secondaryText = item.value.toCurrency()
        content.prefersSideBySideTextAndSecondaryText = true
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let templates = delegate?.getTemplates() else { return }
        let section = templates[indexPath.section]
        let item = templates[indexPath.section].items[indexPath.row]
        delegate?.select(at: .templateEdit(item.id, section.type))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.delete(at: indexPath)
        }
    }
}
