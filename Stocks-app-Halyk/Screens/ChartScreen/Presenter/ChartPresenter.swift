//
//  ChartPresenter.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 31.05.2022.
//

import Foundation

protocol ChartViewProtocol: AnyObject {
    func updateChartView(with chartModel: ChartModel)
    func updateChartView(withLoader isLoading: Bool)
    func updateChartView(withError message: String)
}

protocol ChartPresentProtocol {

    var titleModel: DetailTitleView.TilteModel { get }
    var favoriteButtonIsSelected: Bool { get }
    func loadGraphData()
    func favoriteButtonTapped()
}

class ChartsPresenter: ChartPresentProtocol {
    
    lazy var titleModel: DetailTitleView.TilteModel = {
        .from(stockModel: model)
    }()

    private let model: StockModelProtocol
    
    private let service: ChartServiceProtocol
    
    weak var view: ChartViewProtocol?
    
    var chartModel: ChartModel
    
    
    var favoriteButtonIsSelected: Bool {
        model.isFavotite
    }
    
    init(model: StockModelProtocol, service: ChartServiceProtocol, chartModel: ChartModel) {
        self.model = model
        self.service = service
        self.chartModel = chartModel
    }
    
    func loadGraphData() {
        view?.updateChartView(withLoader: true)
        
        service.getCharts(id: model.id, currency: "usd", days: "367", isDaily: true) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.view?.updateChartView(withLoader: false)
                switch result {
                case .success(let chartData):
                    self?.view?.updateChartView(with: self?.chartModel.allPrices(from: chartData) ?? ChartModel(dictiOFPeriod: [:]))
                case .failure(let error):
                    self?.view?.updateChartView(withError: error.rawValue)
                }
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
}
