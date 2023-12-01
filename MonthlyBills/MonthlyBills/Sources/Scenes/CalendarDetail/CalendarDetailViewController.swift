//
//  
//  CalendarDetailViewController.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 01/12/23.
//
//

import SharpnezDesignSystem
import UIKit

protocol CalendarDetailViewControllerDelegate {
    func getCalendar() -> AnnualCalendarViewModel
    func didSelectMonthlyBill(at row: Int)
}

protocol CalendarDetailViewControlling {
    
}

final class CalendarDetailViewController: UIVIPBaseViewController<CalendarDetailView, CalendarDetailInteracting, CalendarDetailRouting> {
    
    // MARK: Properties
    
    private let calendar: AnnualCalendarViewModel
    
    // MARK: Init
    
    init(
        calendar: AnnualCalendarViewModel,
        customView: CalendarDetailView,
        interactor: CalendarDetailInteracting,
        router: CalendarDetailRouting
    ) {
        self.calendar = calendar
        super.init(customView: customView, interactor: interactor, router: router)
    }
    
    // MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    
    private func configure() {
        title = "Calendar \(calendar.year)"
        customView.reloadData()
    }
}

extension CalendarDetailViewController: CalendarDetailViewControlling {
    
    // MARK: Controller Input
    
    
}

extension CalendarDetailViewController: CalendarDetailViewControllerDelegate {
    
    // MARK: Controller Delegate
    
    func getCalendar() -> AnnualCalendarViewModel {
        return calendar
    }
    
    func didSelectMonthlyBill(at row: Int) {
        let _ = calendar.monthlyBills[row]
    }
}
