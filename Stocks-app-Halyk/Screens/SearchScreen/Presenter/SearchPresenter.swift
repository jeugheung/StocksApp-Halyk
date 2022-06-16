//
//  SearchPresenter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 10.06.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol SearchPresenterProtocol {
    var view: SearchViewProtocol? { get set }
    var itemsCount: Int { get }
    var stoks: [StockModelProtocol] { get }
    
    func searchStocks(searcher: String?)
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class SearchPresenter: SearchPresenterProtocol {
    
    var lastSearch: [String] = []
    
    private let service: StocksServiceProtocol
    var stoks: [StockModelProtocol] = []
    
    var itemsCount: Int {
        stoks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: SearchViewProtocol?
    
    func searchStocks(searcher: String?) {
        startObservingFavoriteNotification()
        view?.updateView(withLoader: true)
        
        if let searcher = searcher, !searcher.isEmpty {
            service.getStocks { [weak self] result in
                self?.view?.updateView(withLoader: false)
                switch result {
                case .success(let stocks):
                    let search = stocks.filter({ $0.name.lowercased().contains(searcher.lowercased()) || $0.symbol.lowercased().contains(searcher.lowercased()) })
                    self?.stoks = search
                    self?.view?.updateView()
                case .failure(let error):
                    self?.view?.updateView(withError: error.localizedDescription)
                }
            }
        } else if searcher == nil {
            self.stoks = []
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stoks[indexPath.row]
    }
}

extension SearchPresenter: FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockId, let index = stoks.firstIndex(where: { $0.id == id }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        view?.updateCell(for: indexPath)
    }
}
