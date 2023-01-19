//
//  AppDelegate.swift
//  Compatibiltiy
//
//  Created by Nirajan on 18/1/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRoot()
        return true
    }
    
    // MARK: setupRoot
    private func setupRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = CompatibilityViewController(screenView: CompatibilityView())
        window?.makeKeyAndVisible()
    }
}
