//
//  StockModel.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 29.05.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changePerc: String { get }
    var changeColor: UIColor { get }
    
    var isFavotite: Bool { get set }
}

final class StockModel: StockModelProtocol {
    private let stock: Stock

    init(stock: Stock) {
        self.stock = stock
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        String(format: "$%.2f", stock.price)
    }
    
    var change: String {
        "\(String(format: "%.2f", stock.change))$"
    }
    
    var changePerc: String {
        "(\(String(format: "%.2f", stock.changePercentage))%)"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .green : .red
    }
    
    var isFavotite: Bool = false
}
