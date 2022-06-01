//
//  ChartViewController.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import UIKit

class ChartViewController: UIViewController {
    
    var presenter: ChartPresentProtocol
    
    init(with presenter: ChartPresentProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Montserrat", size: 18)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        return titleLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Name"
        subtitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        return subtitleLabel
    }()
    
    private lazy var summaryChangedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "dd"
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
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star") , style: .plain, target: self, action: nil)
        return button
        
    }()
    
    private lazy var canvasGraph: UIView = {
        let canvasGraph = UIView()
        canvasGraph.translatesAutoresizingMaskIntoConstraints = false
        canvasGraph.backgroundColor = .systemGray
        return canvasGraph
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setUpConstrains()
        navigationSetup()
        
    }
    
    func configureLabelViews(with model: StockModelProtocol) {
        titleLabel.text = model.symbol.uppercased()
        subtitleLabel.text = model.name
        summaryChangedLabel.text = model.price
        summaryPercentageLabel.text = "\(model.change) \(model.changePerc)"
    }
    
    
    private func setupViews() {
        view.addSubview(summaryChangedLabel)
        view.addSubview(summaryPercentageLabel)
        view.addSubview(canvasGraph)
        setUpStackView()
        view.addSubview(stackView)
        navigationItem.titleView = stackView
        navigationItem.rightBarButtonItem = starButton
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
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
        
        /// canvas
        canvasGraph.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
        canvasGraph.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasGraph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        canvasGraph.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -212).isActive = true
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
    
}
