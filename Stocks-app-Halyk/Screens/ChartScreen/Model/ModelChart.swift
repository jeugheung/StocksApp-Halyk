//
//  ModelChart.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import Foundation

protocol ChartPricesModelProtocol {
    var prices: [[Double]] { get }
}

final class ChartPricesModel: ChartPricesModelProtocol {
    
    private let stockPrices: ChartPrices
    
    init(stockPrices: ChartPrices) {
        self.stockPrices = stockPrices
    }
    
    var prices: [[Double]] {
        stockPrices.prices
    }
}
