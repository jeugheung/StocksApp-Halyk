//
//  ModuleBuilder.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 29.05.2022.
//

import Foundation
import UIKit

final class ModuleBuilder {
    private init() {}
    
    private lazy var network: NetworkService = {
        Network()
    }()
    
    let favoritesService: FavoriteServiceProtocol = FavoritesLocalService()
    
    static let shared: ModuleBuilder = .init()
    
    func networkService() -> NetworkService {
        network
    }
    
    func stocksService() -> StocksServiceProtocol {
        StocksService(client: network)
    }
    
    func stockServiceTwo() -> ChartServiceProtocol {
        ChartService(client: network)
    }
    
    func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService())
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    func secondVC() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService())
        let view = FavoriteViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: .add, tag: 0)
        
        let secondVC = UINavigationController(rootViewController: secondVC())
        secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star.png"), tag: 2)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 2)
        
        tabbar.viewControllers = [stocksVC, secondVC, thirdVC]
        
        return tabbar
    }
}
