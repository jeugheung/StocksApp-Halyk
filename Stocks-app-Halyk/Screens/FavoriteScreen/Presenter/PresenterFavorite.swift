//
//  PresenterFavorite.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 01.06.2022.
//

import Foundation
import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol FavoritePresenterProtocol {
    var view: FavoriteViewProtocol? { get set }
    var itemsCount: Int { get }
    var stoks: [StockModelProtocol] { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class FavoritePresenter: FavoritePresenterProtocol {
    
    private let service: StocksServiceProtocol
    var stoks: [StockModelProtocol] = []
    
    var itemsCount: Int {
        stoks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: FavoriteViewProtocol?
    
    func loadView() {
        
        view?.updateView(withLoader: true)

        service.getStocks { [weak self] result in
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                let firstVcStocks = stocks.map { StockModel(stock: $0) }
                self?.stoks = firstVcStocks.filter({ stock in
                    stock.isFavotite == true
                })
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stoks[indexPath.row]
    }
}



