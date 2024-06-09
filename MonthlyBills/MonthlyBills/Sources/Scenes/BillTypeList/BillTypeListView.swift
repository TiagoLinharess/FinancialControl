//
//  BillTypeListView.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//

import SharpnezDesignSystem
import SnapKit
import UIKit

protocol BillTypeListViewDelegate {
    func toggle(id: String)
    func delete(with id: String)
    func organize(billTypes: [BillTypeViewModel])
}

final class BillTypeListView: UIView {
    
    // MARK: Properties
    
    var delegate: BillTypeListViewDelegate?
    private var billTypes: [BillTypeViewModel] = []
    
    // MARK: UI Elements
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.register(BillTypeTableViewCell.self, forCellReuseIdentifier: BillTypeTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.dragInteractionEnabled = true
        tableView.isUserInteractionEnabled = true
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
    
    func presentSuccess(billTypes: [BillTypeViewModel]) {
        self.billTypes = billTypes
        tableView.reloadData()
    }
}

extension BillTypeListView: UIViewCode {
    
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

extension BillTypeListView: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    // MARK: UITableview Delegate & DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BillTypeTableViewCell.identifier,
            for: indexPath
        ) as? BillTypeTableViewCell
        else {
            return UITableViewCell()
        }

        let billType = billTypes[indexPath.row]
        cell.configure(viewModel: billType)
        cell.onToggleSwitch = delegate?.toggle
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        Constants.BilltypesList.listTips
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = billTypes[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = billTypes.remove(at: sourceIndexPath.row)
        billTypes.insert(mover, at: destinationIndexPath.row)
        delegate?.organize(billTypes: billTypes)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.delete(with: billTypes[indexPath.row].id)
            billTypes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
