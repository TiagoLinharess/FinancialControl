//
//  
//  CalendarDetailViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import Core
import SharpnezDesignSystem
import UIKit

protocol CalendarDetailViewControllerDelegate {
    func getCalendar() -> AnnualCalendarViewModel?
    func didSelectMonthlyBill(at row: Int)
}

protocol CalendarDetailViewControlling {
    func presentSuccess(newCalendar: AnnualCalendarViewModel)
    func presentError(message: String)
}

final class CalendarDetailViewController: UIVIPBaseViewController<CalendarDetailView, CalendarDetailInteracting, CalendarDetailRouting> {
    
    // MARK: Properties
    
    private let currentYear: String
    private var calendar: AnnualCalendarViewModel?
    
    // MARK: Init
    
    init(
        currentYear: String,
        customView: CalendarDetailView,
        interactor: CalendarDetailInteracting,
        router: CalendarDetailRouting
    ) {
        self.currentYear = currentYear
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.update(at: currentYear)
    }
    
    // MARK: Configure
    
    private func configure() {
        guard let calendar else { return }
        
        title = String(format: Constants.CalendarDetailView.title, calendar.year)
        customView.reloadData()
        
        let cancelButton = UIBarButtonItem(image: .init(systemName: CoreConstants.Icons.close), style: .plain, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItems = [cancelButton]
    }
    
    // MARK: Actions
    
    @objc
    func cancelAction() {
        router.close()
    }
}

extension CalendarDetailViewController: CalendarDetailViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(newCalendar: AnnualCalendarViewModel) {
        self.calendar = newCalendar
        configure()
    }
    
    func presentError(message: String) {
        presentFeedbackDialog(
            with: FeedbackModel(
                title: CoreConstants.Commons.AlertTitle,
                description: message,
                buttons: [.init(title: CoreConstants.Commons.ok, style: .default)]
            )
        )
    }
}

extension CalendarDetailViewController: CalendarDetailViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getCalendar() -> AnnualCalendarViewModel? {
        return calendar
    }
    
    func didSelectMonthlyBill(at row: Int) {
        guard let bill = calendar?.monthlyBills[row] else { return }
        router.routeToBill(billId: bill.id)
    }
}
