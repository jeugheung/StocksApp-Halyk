//
//  ChartViewController.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import UIKit

class ChartViewController: UIViewController {
    
    private let summary: Summary
    
    private lazy var titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = summary.symbol.uppercased()
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = summary.name
        subtitleLabel.font = .boldSystemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var summaryChangedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(summary.currentPrice) + \(summary.id)"
        label.font = UIFont(name: "Montserrat", size: 28)
        label.frame = CGRect(x: 0, y: 0, width: 98, height: 32)
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        let color = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        label.textColor = color
        return label
    }()
    
    private lazy var summaryPercentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(summary.changePrice) \(summary.changePerc)"
        label.font = UIFont(name: "Montserrat", size: 12)
        label.frame = CGRect(x: 0, y: 0, width: 78, height: 16)
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        let color = UIColor(red: 0.14, green: 0.7, blue: 0.364, alpha: 1)
        label.textColor = color
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = titleStackView
        setupViews()
        setUpConstrains()
        navigationSetup()
        barButtonNav()
        
    }
    
    init(summary: Summary) {
        self.summary = summary
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(summaryChangedLabel)
        view.addSubview(summaryPercentageLabel)
    }
    
    private func setUpConstrains() {
        
        /// Label 1
        summaryChangedLabel.widthAnchor.constraint(equalToConstant: 98).isActive = true
        summaryChangedLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        summaryChangedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        summaryChangedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162).isActive = true
        
        /// Label 2
        summaryPercentageLabel.widthAnchor.constraint(equalToConstant: 78).isActive = true
        summaryPercentageLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        summaryPercentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        summaryPercentageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 202).isActive = true
    }
    
    private func navigationSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func barButtonNav() {
        let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = testUIBarButtonItem
    }
}
