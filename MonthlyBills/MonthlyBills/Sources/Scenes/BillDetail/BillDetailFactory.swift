//
//  
//  BillDetailFactory.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 05/12/23.
//
//

import UIKit

enum BillDetailFactory {
    
    static func configure(billId: String) -> UIViewController {
        let router = BillDetailRouter()
        let presenter = BillDetailPresenter()
        let interactor = BillDetailInteractor(presenter: presenter)
        let view = BillDetailView()
        
        let controller = BillDetailViewController(
            billId: billId,
            customView: view,
            interactor: interactor,
            router: router
        )
        
        view.delegate = controller
        router.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
