//
//  ChartRouter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

enum ChartRouter: Router {
    
    case charts(id: String, currency: String, days: String, isDaily: Bool)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .charts(let id, _, _, _):
            return "/api/v3/coins/\(id)/market_chart"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .charts:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .charts(_, currency, days, isDaily):
            return ["vs_currency": currency, "days": days, "interval": isDaily ? "daily" : ""]
        }
    }
}
