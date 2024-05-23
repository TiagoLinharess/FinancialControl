//
//  
//  LoginInteractor.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import Foundation
import SharpnezDesignSystem

protocol LoginInteracting { 
    func verifyAuthSelection()
    func useFaceID()
}

final class LoginInteractor: UIVIPInteractor<LoginPresenting>, LoginInteracting {
    
    // MARK: Properties
    
    private let worker: LoginWorking
    
    // MARK: Init
    
    init(presenter: LoginPresenting, worker: LoginWorking = LoginWorker()) {
        self.worker = worker
        super.init(presenter: presenter)
    }
    
    // MARK: Methods
    
    func verifyAuthSelection() {
        do {
            let type = try worker.verifySessionType()
            presenter.presentAuthType(authType: type)
        } catch {
            presenter.presentError()
        }
    }
    
    func useFaceID() {
        worker.makeFaceID { [weak self] success in
            if success {
                self?.presenter.faceIDSuccess()
                return
            }
            
            self?.presenter.faceIDError()
        }
    }
}
