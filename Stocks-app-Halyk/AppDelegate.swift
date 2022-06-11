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
    let appearance = UINavigationBarAppearance()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Assembly.assembler.tabbarController()
        window?.makeKeyAndVisible()
        
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return true
    }
}
