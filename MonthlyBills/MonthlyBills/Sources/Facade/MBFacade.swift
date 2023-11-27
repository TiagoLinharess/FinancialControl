//
//  MBFacade.swift
//  MonthlyBills
//
//  Created by Tiago Linhares on 26/11/23.
//

import Foundation

import UIKit

public final class MBFacade {
    
    public init() { }
    
    public func start() -> UIViewController {
        return HomeFactory.configure()
    }
}
