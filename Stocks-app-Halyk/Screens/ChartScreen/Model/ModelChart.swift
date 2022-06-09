//
//  ModelChart.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import Foundation

struct ChartModel {
    
    var dictiOFPeriod: [String: [Double]]
    
    func allPrices(from response: ChartPrices) -> ChartModel {
        let weeklyPrices = Array(response.prices.map { $0.price }.suffix(7))
        let monthly = Array(response.prices.map { $0.price }.suffix(31))
        let sixMonthly = Array(response.prices.map { $0.price }.suffix(186))
        let year = Array(response.prices.map { $0.price }.suffix(365))
        return ChartModel(dictiOFPeriod: ["weekly": weeklyPrices, "monthly": monthly,
                                          "sixMonthly": sixMonthly, "year": year])
    }
}
