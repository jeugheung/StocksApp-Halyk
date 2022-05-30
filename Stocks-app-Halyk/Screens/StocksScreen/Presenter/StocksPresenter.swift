//
//  StocksPresenter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 29.05.2022.
//

import Foundation
import UIKit

protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var itemsCount: Int { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
    private let service: StocksServiceProtocol
    private var stoks: [StockModelProtocol] = []
    
    var itemsCount: Int {
        stoks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    weak var view: StocksViewProtocol?
    
    func loadView() {
        // Идем в сеть и показываем лоадер
        view?.updateView(withLoader: true)
        
        service.getStocks { [weak self] result in
            // Возвращаемся с данными и убираем лоадер
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stoks = stocks.map { StockModel(stock: $0) }
                print(stocks[2].id)
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
