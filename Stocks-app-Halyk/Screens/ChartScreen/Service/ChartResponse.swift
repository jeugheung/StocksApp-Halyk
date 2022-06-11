//
//  ChartResponse.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

struct ChartPrices: Decodable {
    let prices: [Price]
    
    struct Price: Decodable {
        let date: Date
        let price: Double
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let array = try container.decode([Double].self)
            
            guard let time = array[safe: 0], let price = array[safe: 1] else { throw NSError() }
            let date = Date(timeIntervalSince1970: TimeInterval(time/1000))
            
            self.price = price
            self.date = date
        }
    }
}

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
