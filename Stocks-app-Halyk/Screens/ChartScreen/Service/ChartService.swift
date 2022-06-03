//
//  ChartService.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

protocol ChartServiceProtocol {
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void)
    func getCharts(id: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void)
}

final class ChartService: ChartServiceProtocol {
    
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void) {
        client.execute(with: ChartRouter.charts(id: id, currency: currency, days: days, isDaily: isDaily), completion: completion)
    }
}


extension ChartServiceProtocol {
    func getCharts(id: String, completion: @escaping (Result<ChartPrices, NetworkError>) -> Void) {
            getCharts(id: id, currency: "usd", days: "100", isDaily: true, completion: completion)
    }
}


