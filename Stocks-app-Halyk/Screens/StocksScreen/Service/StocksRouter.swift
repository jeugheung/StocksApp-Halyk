//
//  StocksRouter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 29.05.2022.
//

import Foundation

enum StocksRouter: Router {
    case stocks(carrency: String, count: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let carrency, let count):
            return ["vs_currency": carrency, "per_page": count]
        }
    }
}
