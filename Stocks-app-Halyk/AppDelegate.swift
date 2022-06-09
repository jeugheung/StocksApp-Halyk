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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ModuleBuilder.shared.tabbarController()
        window?.makeKeyAndVisible()
        return true
        
    }
}






