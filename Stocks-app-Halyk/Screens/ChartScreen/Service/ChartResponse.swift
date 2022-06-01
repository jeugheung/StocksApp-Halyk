//
//  ChartResponse.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

struct ChartPrices: Decodable {
    let prices: [[Double]]
}
