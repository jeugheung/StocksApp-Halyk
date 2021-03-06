//
//  StockService.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import Foundation

fileprivate enum Constants {
    static let currency = "usd"
    static let count = "50"
}

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
}

final class StocksService: StocksServiceProtocol {

    private let network: NetworkService
    
    private var stocks: [StockModelProtocol] = []
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        if stocks.isEmpty {
            fetch(currency: currency, count: count, completion: completion)
            return
        }
        
        completion(.success(stocks))
    }
    
    private func fetch(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        network.execute(with: StocksRouter.stocks(carrency: currency, count: count)) { [weak self] (result: Result<[Stock], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let stocks):
                completion(.success(self.stockModels(for: stocks)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func stockModels(for stocks: [Stock]) -> [StockModelProtocol] {
        stocks.map { StockModel(stock: $0) }
    }
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: currency, count: Constants.count, completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: Constants.currency, completion: completion)
    }
}

