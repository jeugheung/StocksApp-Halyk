//
//  AppDelegate.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 25.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let StockVC = UINavigationController(rootViewController: StocksViewController())
        
        let tabBar = UITabBarController()
        tabBar.setViewControllers([StockVC], animated: true)
        
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
}

