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
    
    
    private lazy var stocksService: StocksServiceProtocol =
        StocksService(client: network)
    
    
    private lazy var stockServiceTwo: ChartServiceProtocol =
        ChartService(client: network)
    
    func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    func secondVC() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService)
        let view = FavoriteViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = stocksModule()
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "line-chart.png"), tag: 0)
        
        let secondVC = secondVC()
        secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star.png"), tag: 1)
        
        let thirdVC = thirdVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 2)
        
        tabbar.viewControllers = [stocksVC, secondVC, thirdVC].map { UINavigationController (rootViewController: $0)}
        return tabbar
    }
    
    func detailVC(for model: StockModelProtocol) -> UIViewController {
        let presneter = ChartsPresenter(model: model, service: stockServiceTwo, chartModel: ChartModel(dictiOFPeriod: [:]))
        let view = ChartViewController(with: presneter)
        presneter.view = view
        return view
    }
    
}
