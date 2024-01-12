//
//  TestUtils.swift
//  WeeklyBudgetsTests
//
//  Created by Tiago Linhares on 21/11/23.
//

import SwiftUI

public enum TestUtils {
    
    public static func get_swiftui_view_ready_for_snapshot(view: some View) -> UIViewController {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return controller
    }
    
    public static func get_window_for_snapshot(controller: UIViewController) -> UIWindow {
        let mockWindow = UIWindow()
        let navigation = UINavigationController(rootViewController: controller)
        mockWindow.rootViewController = navigation
        mockWindow.makeKeyAndVisible()
        mockWindow.frame = .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return mockWindow
    }
}
