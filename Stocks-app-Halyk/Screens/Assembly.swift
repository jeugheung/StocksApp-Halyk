//
//  Assembly.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 29.05.2022.
//

import Foundation
import UIKit

final class Assembly {
    private init() {}
    
    static let assembler: Assembly = .init()
    let favoritesService: FavoriteServiceProtocol = FavoritesLocalService()
    
    private lazy var network: NetworkService = Network()
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
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
    
    func searchVC() -> UIViewController {
        let presenter = SearchPresenter(service: stocksService)
        let view = SearchView(presenter: presenter)
        presenter.view = view
        return view
    }
    
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = stocksModule()
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
        
        let secondVC = secondVC()
        secondVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star3.pdf"), tag: 1)
        
        let thirdVC = searchVC()
        thirdVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "searchNav.pdf"), tag: 2)
        
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
