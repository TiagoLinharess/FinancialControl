//
//  HomeViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 10/11/23.
//

import Core
import SharpnezDesignSystem
import UIKit

protocol AddBillDelegate {
    func didAddBill()
}

protocol HomeViewControlling {
    func presentSuccess(bills: [AnnualBillsViewModel])
    func presentEmpty()
    func presentError(message: String?)
}

final class HomeViewController: UIVIPBaseViewController<HomeView, HomeInteracting, HomeRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchBills()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.bills
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        customView.onActionError = interactor.fetchBills
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [button]
    }
    
    // MARK: Actions
    
    @objc
    func didTapAddButton() {
        router.routeToAdd()
    }
}

extension HomeViewController: HomeViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(bills: [AnnualBillsViewModel]) {
        customView.presentSuccess(bills: bills)
    }
    
    func presentEmpty() {
        customView.presentEmpty()
    }
    
    func presentError(message: String?) {
        customView.presentError(message: message)
    }
}

extension HomeViewController: AddBillDelegate {
    
    // MARK: Add Bill Delegate
    
    func didAddBill() {
        interactor.fetchBills()
    }
}
