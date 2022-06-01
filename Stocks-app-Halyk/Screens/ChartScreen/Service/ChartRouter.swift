//
//  ChartRouter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

enum ChartRouter: Router {
    
    case stock(id: String, currency: String, daysCount: String, intervalDaily: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stock(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stock:
            return .get
        }
    
    }
    
    var parameters: Parameters {
        switch self {
        case .stock(_, let currency, let daysCount, let intervalDaily):
            return ["vs_currency": currency, "days": daysCount, "interval": intervalDaily]
        }
    }
    
}
