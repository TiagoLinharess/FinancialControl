//
//  
//  LoginInteractor.swift
//  Login
//
//  Created by Tiago Linhares on 30/04/24.
//
//

import Foundation
import SharpnezCore
import SharpnezDesignSystem

protocol LoginInteracting { 
    func verifyAuthSelection()
    func useFaceID()
    func usePassword(password: String)
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
                self?.presenter.presentFaceIDSuccess()
                return
            }
            
            self?.presenter.presentFaceIDError()
        }
    }
    
    func usePassword(password: String) {
        do {
            try worker.makeCustomPassword(password: password)
            presenter.presentPasswordSuccess()
        } catch {
            presenter.presentPasswordError(error: (error as? CoreError) ?? .genericError)
        }
    }
}
