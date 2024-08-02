//
//  AddAnnualCalendarViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 27/11/23.
//

import Core
import SharpnezCore
import SharpnezDesignSystem
import UIKit

protocol AddAnnualCalendarViewControlling {
    func setYears(years: [String])
    func presentSuccess()
    func presentError(message: String?)
}

final class AddAnnualCalendarViewController: UIVIPBaseViewController<AddAnnualCalendarView, AddAnnualCalendarInteracting, AddAnnualCalendarRouting> {
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchAvailableYears()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = Constants.AddAnnualCalendarView.title
        
        let cancelButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.close), style: .plain, target: self, action: #selector(cancelAction))
        let doneButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.check), style: .plain, target: self, action: #selector(doneAction))
        
        navigationItem.leftBarButtonItems = [cancelButton]
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    // MARK: Actions
    
    @objc
    func cancelAction() {
        router.close()
    }
    
    @objc
    func doneAction() {
        let year = customView.getSelectedYear()
        interactor.submit(year: year)
    }
    
    func finishAction() {
        router.finish()
    }
}

extension AddAnnualCalendarViewController: AddAnnualCalendarViewControlling {
    
    // MARK: Controller Input
    
    func setYears(years: [String]) {
        customView.setYears(years: years)
    }
    
    func presentSuccess() {
        finishAction()
    }
    
    func presentError(message: String?) {
        presentFeedbackDialog(
            with: .init(
                title: CoreConstants.Commons.AlertTitle,
                description: message ?? CoreError.genericError.message,
                buttons: [.init(title: CoreConstants.Commons.ok, style: .default)]
            )
        )
    }
}
