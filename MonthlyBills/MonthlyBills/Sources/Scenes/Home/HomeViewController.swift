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

protocol HomeViewControllerDelegate {
    func getCalendars() -> [AnnualCalendarViewModel]
    func didSelectCalendar(at row: Int)
    func errorAction()
}

protocol HomeViewControlling {
    func presentSuccess(calendars: [AnnualCalendarViewModel])
    func presentEmpty()
    func presentError(message: String?)
}

final class HomeViewController: UIVIPBaseViewController<HomeView, HomeInteracting, HomeRouting> {
    
    // MARK: Properties
    
    var calendars: [AnnualCalendarViewModel] = []
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchCalendars()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = CoreConstants.Commons.bills
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [button]
    }
    
    // MARK: Actions
    
    @objc
    func didTapAddButton() {
        router.routeToAdd(delegate: self)
    }
}

extension HomeViewController: HomeViewControlling {
    
    // MARK: Controller Input
    
    func presentSuccess(calendars: [AnnualCalendarViewModel]) {
        self.calendars = calendars
        customView.presentSuccess()
    }
    
    func presentEmpty() {
        customView.presentEmpty()
    }
    
    func presentError(message: String?) {
        customView.presentError(message: message)
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getCalendars() -> [AnnualCalendarViewModel] {
        return calendars
    }
    
    func didSelectCalendar(at row: Int) {
        let calendar = calendars[row]
        router.routeToDetail(calendar: calendar)
    }
    
    func errorAction() {
        interactor.fetchCalendars()
    }
}

extension HomeViewController: AddBillDelegate {
    
    // MARK: Add Bill Delegate
    
    func didAddBill() {
        interactor.fetchCalendars()
    }
}
