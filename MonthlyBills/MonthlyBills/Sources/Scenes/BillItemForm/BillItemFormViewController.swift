//
//  
//  BillItemFormViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 18/01/24.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol BillItemFormViewControlling {
    /* Impements protocol code */
}

final class BillItemFormViewController: UIVIPBaseViewController<BillItemFormView, BillItemFormInteracting, BillItemFormRouting> {
    
    // MARK: Properties
    
    private let billItemFormViewModel: BillItemFormViewModel
    
    // MARK: Init
    
    init(
        billItemFormViewModel: BillItemFormViewModel,
        customView: BillItemFormView,
        interactor: BillItemFormInteracting,
        router: BillItemFormRouting
    ) {
        self.billItemFormViewModel = billItemFormViewModel
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = "Item"
        let checkButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(checkAction))
        navigationItem.rightBarButtonItems = [checkButton]
    }
    
    // MARK: Actions
    
    @objc
    func checkAction() {
        
    }
}

extension BillItemFormViewController: BillItemFormViewControlling {
    
    // MARK: Controller Input
    
    /* Impements controller code */
}
