//
//  XCTestCase+Extensions.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 21/11/23.
//

import SnapshotTesting
import SwiftUI
import XCTest

public extension XCTestCase {
    func get_swiftui_view_ready_for_snapshot(view: some View) -> UIViewController {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return controller
    }
}
