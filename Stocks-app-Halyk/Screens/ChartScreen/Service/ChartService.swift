//
//  ChartService.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

protocol ChartServiceProtocol {
    func getStock(id: String, currency: String, daysCount: String, interval: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void)
    func getStock(id: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void)
}

final class ChartService: ChartServiceProtocol {
    
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStock(id: String, currency: String, daysCount: String, interval: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void) {
        client.execute(with: ChartRouter.stock(id: id, currency: currency, daysCount: daysCount, intervalDaily: interval), completion: completion)
    }
}

extension ChartServiceProtocol {
    func getStock(id: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void) {
        getStock(id: id, currency: "usd", daysCount: "600", interval: "daily", completion: completion)
    }
}


