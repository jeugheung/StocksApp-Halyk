//
//  StocksViewController.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {
    
    private var stocks: [Stock] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        return tableView
    }()
    
    private let colorForOCell = UIColor(r: 240, g: 244, b: 247)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        tableView.dataSource = self
        getStocks()
        
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getStocks() {
        //let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100"
        let client = Network()
        let service: StocksServiceProtocol = StocksService(client: client)
        
        service.getStocks { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showError(error.localizedDescription)
            }
        }
    }
    
    func showError(_ message: String) {
        ///
    }
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.configure(with: stocks[indexPath.row])
        
        if indexPath.row.isMultiple(of: 2) {
            cell.cellView.backgroundColor = colorForOCell
        } else {
            cell.cellView.backgroundColor = .white
        }
        return cell
        
    }
}

struct Stock: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let price: Double
    let change: Double
    let changePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case price = "current_price"
        case change = "price_change_24h"
        case changePercentage = "price_change_percentage_24h"
    }
}





