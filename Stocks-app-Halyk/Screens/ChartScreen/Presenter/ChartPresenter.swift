//
//  ChartPresenter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

protocol ChartViewProtocol: AnyObject {
    func updateChartView()
    func updateChartView(withLoader isLoading: Bool)
    func updateChartView(withError message: String)
}

protocol ChartPresentProtocol {
    var id: String { get set }
    var view: ChartViewProtocol? { get set }
    func loadGraphData(with idOfStock: String)
    init(with id: String, withService service: ChartServiceProtocol)
}

class ChartsPresenter: ChartPresentProtocol {
    
    weak var view: ChartViewProtocol?
    
    var service: ChartServiceProtocol

    var stockPrices: ChartPricesModelProtocol?

    var id: String

    required init(with id: String, withService service: ChartServiceProtocol) {
        self.id = id
        self.service = service
    }


    func loadGraphData(with idOfStock: String) {
        id = idOfStock
        service.getStock(id: id) { [weak self] result in
            
            switch result {
            case .success(let pricesOfStock):
                self?.stockPrices = pricesOfStock as? ChartPricesModelProtocol
                print(pricesOfStock)

            case .failure(let error):
                self?.view?.updateChartView(withError: error.localizedDescription)
            }
        }
   }
}
