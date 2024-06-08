//
//  
//  BillTypeListViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 08/06/24.
//
//

import SharpnezDesignSystem
import UIKit

protocol BillTypeListViewControlling {
    // TODO: protocol code
}

final class BillTypeListViewController: UIVIPBaseViewController<BillTypeListView, BillTypeListInteracting, BillTypeListRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = Constants.BilltypesList.title
    }
}

extension BillTypeListViewController: BillTypeListViewControlling {
    
    // MARK: Controller Input
    
    // TODO: controller code
}
