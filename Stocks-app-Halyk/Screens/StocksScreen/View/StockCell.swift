//
//  StockCell.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 25.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    
    private var favoriteAction: (() -> Void)?
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "AAPL.pdf")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AAPL"
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return label
    }()
    
    private lazy var corporationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apple Inc."
        label.font = UIFont(name: "Montserrat-SemiBold", size: 11)
        return label
    }()

    private lazy var starButton: UIButton = {
        let button = UIButton()
        let colorForStar = UIColor(r: 186, g: 186, b: 186)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "star.pdf"), for: .normal)
        button.setImage(UIImage(named: "star1.pdf"), for: .selected)
        button.tintColor = colorForStar
        button.addTarget(self, action: #selector(favouriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$131.93"
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        return label
    }()
    
    private lazy var changedPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+$0,12 (1,15%)"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        let color = UIColor(r: 36, g: 178, b: 93)
        label.textColor = color
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteAction = nil
    }
    
    func configure(with model: StockModelProtocol) {
        symbolLabel.text = model.symbol.uppercased()
        corporationNameLabel.text = model.name
        currentPriceLabel.text = model.price
        changedPriceLabel.text = "\(model.change) \(model.changePerc)"
        changedPriceLabel.textColor = model.changeColor
        starButton.isSelected = model.isFavotite
        favoriteAction = {
            model.setFavorite()
        }
    }
    
    @objc private func favouriteButtonTap() {
        starButton.isSelected.toggle()
        favoriteAction?()
    }
    
    private func setUpViews() {
        contentView.addSubview(cellView)
        [iconView, symbolLabel, corporationNameLabel, starButton, currentPriceLabel, changedPriceLabel].forEach{
            cellView.addSubview($0)
        }
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellView.heightAnchor.constraint(equalToConstant: 68),
            
            iconView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            iconView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            iconView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            symbolLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14),
            
            corporationNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            corporationNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14),
            
            starButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
            starButton.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
            starButton.widthAnchor.constraint(equalToConstant: 16),
            starButton.heightAnchor.constraint(equalToConstant: 16),
            
            currentPriceLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14),
            currentPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -17),
            
            changedPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            changedPriceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14)
        ])
    }
}
