//
//  AppDelegate.swift
//  BirdApp
//
//  Created by Nelson Ramirez on 28-08-22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ListBirdViewController())
        navigationController.navigationBar.prefersLargeTitles = false
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

