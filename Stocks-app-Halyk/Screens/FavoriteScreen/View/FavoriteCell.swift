//
//  FavoriteCell.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 01.06.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
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
        imageView.image = UIImage(named: "AAPL")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AAPL"
        label.font = UIFont(name: "Montserrat", size: 18)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var corporationNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apple Inc."
        label.font = UIFont(name: "Montserrat", size: 11)
        label.font = .boldSystemFont(ofSize: 11)
        return label
    }()
     
    private lazy var starButtonTwo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "star.png"), for: .normal)
        button.setImage(UIImage(named: "star1.png"), for: .selected)
        button.addTarget(self, action: #selector(favouriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$131.93"
        label.font = UIFont(name: "Montserrat", size: 18)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var changedPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+$0,12 (1,15%)"
        label.font = UIFont(name: "Montserrat", size: 12)
        label.font = .boldSystemFont(ofSize: 12)
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
        changedPriceLabel.textColor = { model.changeColor }()
        starButtonTwo.isSelected = model.isFavotite
        favoriteAction = {
            model.setFavorite()
        }
    }
    
    @objc private func favouriteButtonTap() {
        starButtonTwo.isSelected.toggle()
        favoriteAction?()
    }
    
    
    private func setUpViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(iconView)
        cellView.addSubview(symbolLabel)
        cellView.addSubview(corporationNameLabel)
        cellView.addSubview(starButtonTwo)
        cellView.addSubview(currentPriceLabel)
        cellView.addSubview(changedPriceLabel)
    }
    
    
    private func setUpConstrains() {

        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 68).isActive = true

        iconView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8).isActive = true
        iconView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        iconView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14).isActive = true
        
        corporationNameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        corporationNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14).isActive = true
        
        starButtonTwo.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6).isActive = true
        starButtonTwo.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16).isActive = true
        starButtonTwo.widthAnchor.constraint(equalToConstant: 16).isActive = true
        starButtonTwo.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        currentPriceLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 14).isActive = true
        currentPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -17).isActive = true
        
        changedPriceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12).isActive = true
        changedPriceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -14).isActive = true
    }
}
