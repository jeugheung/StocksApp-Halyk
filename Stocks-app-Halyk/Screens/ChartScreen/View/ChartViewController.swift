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
    
    
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: presenter.titleModel)
        return view
    }()
    
    private lazy var chartsContainerView: ChartsContainerView = {
        let view = ChartsContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.setTitle("Buy for \(presenter.titleModel.price)", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 328, height: 56)
        button.addTarget(self, action: #selector(buyTap), for: .touchUpInside)
        return button
    }()
    
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
    
    override var hidesBottomBarWhenPushed: Bool {
        get { true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
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
    
    @objc private func buyTap(sender: UIButton) {
        let alert = UIAlertController(title: "Successful purchase", message: "You bought \(presenter.titleModel.name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func setupViews() {
        view.addSubview(summaryChangedLabel)
        view.addSubview(summaryPercentageLabel)
        view.addSubview(chartsContainerView)
        view.addSubview(buyButton)
        
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

        chartsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chartsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 110).isActive = true
        
        buyButton.widthAnchor.constraint(equalToConstant: 328).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130).isActive = true
        
    }
    
}

extension ChartViewController: ChartViewProtocol {
    func updateChartView(with chartModel: ChartModel) {
        chartsContainerView.configureChart(with: chartModel)
    }

    func updateChartView(withLoader isLoading: Bool) {
        chartsContainerView.configure(with: isLoading)
    }

    func updateChartView(withError message: String) {

    }
}



