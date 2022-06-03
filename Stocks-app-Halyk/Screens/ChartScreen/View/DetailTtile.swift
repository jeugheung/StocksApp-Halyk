//
//  DetailTtile.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 03.06.2022.
//

import Foundation
import UIKit

final class DetailTitleView: UIView {
    struct TilteModel {
        let symbol: String
        let name: String
        let price: String
        let change: String
        let changePerc: String
        let color: UIColor
        
        static func from(stockModel model: StockModelProtocol) -> TilteModel {
            TilteModel(symbol: model.symbol, name: model.name, price: model.price,
                       change: model.change, changePerc: model.changePerc,
                       color: { model.changeColor }())
        }
    }
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TilteModel) {
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
       
    }
    
    private func setupSubviews() {
        addSubview(symbolLabel)
        addSubview(nameLabel)

        symbolLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
        symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
