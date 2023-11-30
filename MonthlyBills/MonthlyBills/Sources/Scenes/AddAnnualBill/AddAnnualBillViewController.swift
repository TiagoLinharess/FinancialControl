//
//  AddAnnualBillViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import SharpnezDesignSystem
import UIKit

protocol AddAnnualBillViewControlling {
    func setYears(years: [String])
    func presentSuccess()
    func presentError(message: String?)
}

final class AddAnnualBillViewController: UIVIPBaseViewController<AddAnnualBillView, AddAnnualBillInteracting, AddAnnualBillRouting> {
    
    // MARK: - View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchAvailableYears()
        configure()
    }
    
    // MARK: - Configure
    
    private func configure() {
        title = "Add Annual Bills"
        let doneButton = UIBarButtonItem(image: .init(systemName: "checkmark"), style: .plain, target: self, action: #selector(doneAction))
        navigationItem.rightBarButtonItems = [doneButton]
        
        let cancelButton = UIBarButtonItem(image: .init(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItems = [cancelButton]
    }
    
    // MARK: - Actions
    
    @objc
    func cancelAction() {
        router.close()
    }
    
    @objc
    func doneAction() {
        router.close()
    }
}

extension AddAnnualBillViewController: AddAnnualBillViewControlling {
    
    // MARK: - Controller Input
    
    func setYears(years: [String]) {
        customView.setYears(years: years)
    }
    
    func presentSuccess() {
        //
    }
    
    func presentError(message: String?) {
        //
    }
}
