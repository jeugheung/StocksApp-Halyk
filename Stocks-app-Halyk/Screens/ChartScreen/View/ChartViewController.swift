//
//  ChartViewController.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 27.05.2022.
//

import UIKit

class ChartViewController: UIViewController {
    
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: presenter.titleModel)
        return view
    }()
    
    var presenter: ChartPresentProtocol
    
    init(with presenter: ChartPresentProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var summaryChangedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = presenter.titleModel.price
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
        label.text = "\(presenter.titleModel.change) \(presenter.titleModel.changePerc)"
        label.textColor = presenter.titleModel.color
        label.font = UIFont(name: "Montserrat", size: 12)
        label.frame = CGRect(x: 0, y: 0, width: 78, height: 16)
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        return label
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
        presenter.loadGraphData()
        setupFavoriteButton()
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        button.setImage(UIImage(named: "star1"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = presenter.favoriteButtonIsSelected
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
    }
    
    private func setupViews() {
        view.addSubview(summaryChangedLabel)
        view.addSubview(summaryPercentageLabel)
        view.addSubview(canvasGraph)
    }
    
    private func navigationSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        navigationItem.titleView = titleView
    }
    
    private func setUpConstrains() {

        summaryChangedLabel.widthAnchor.constraint(equalToConstant: 98).isActive = true
        summaryChangedLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        summaryChangedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        summaryChangedLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 162).isActive = true

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
}

extension ChartViewController: ChartViewProtocol {
    func updateChartView() {
        
    }
    
    func updateChartView(withLoader isLoading: Bool) {
        
    }
    
    func updateChartView(withError message: String) {
        
    }
}
