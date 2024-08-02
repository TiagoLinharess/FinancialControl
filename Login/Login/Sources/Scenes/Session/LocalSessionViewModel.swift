//
//  LocalSessionViewModel.swift
//  Login
//
//  Created by Tiago Linhares on 22/06/24.
//

import Foundation

protocol LocalSessionViewModelProtocol: ObservableObject {
    func authenticate()
}

final class LocalSessionViewModel: LocalSessionViewModelProtocol {
    
    // MARK: Properties
    
    private let worker: LoginWorking
    var onClose: ((Bool) -> Void)?
    
    // MARK: Init
    
    init(worker: LoginWorking = LoginWorker()) {
        self.worker = worker
    }
    
    // MARK: Authenticate
    
    func authenticate() {
        worker.makeFaceID { [weak self] success in
            if success {
                self?.onClose?(true)
            }
        }
    }
}
