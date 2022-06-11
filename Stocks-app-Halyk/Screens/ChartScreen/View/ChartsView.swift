//
//  ChartsView.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 05.06.2022.
//

import UIKit
import Charts

final class ChartsContainerView: UIView {
    
    private func chartSettings(chart: LineChartView) {
        chart.pinchZoomEnabled = true
        chart.setScaleEnabled(true)
        chart.xAxis.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.legend.enabled = true
        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
    }

    private lazy var chartsView: [LineChartView] = {
        let weekly = LineChartView()
        weekly.translatesAutoresizingMaskIntoConstraints = false
        chartSettings(chart: weekly)
        weekly.noDataText = ""
        weekly.alpha = 1
        
        let monthly = LineChartView()
        monthly.translatesAutoresizingMaskIntoConstraints = false
        chartSettings(chart: monthly)
        monthly.alpha = 0
        
        let sixMonth = LineChartView()
        sixMonth.translatesAutoresizingMaskIntoConstraints = false
        chartSettings(chart: sixMonth)
        sixMonth.alpha = 0
        
        let year = LineChartView()
        year.translatesAutoresizingMaskIntoConstraints = false
        chartSettings(chart: year)
        year.alpha = 0
        
        return [weekly, monthly, sixMonth, year]
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with isLoading: Bool) {
        isLoading ? loader.startAnimating() : loader.stopAnimating()
        loader.isHidden = !isLoading
        buttonStackView.isHidden = isLoading
    }
    
    func configureChart(with model: ChartModel) {
        let dicc = model.dictiOFPeriod
        
        setCharts(with: dicc["weekly"]!, canvas: chartsView[0])
        setCharts(with: dicc["monthly"]!, canvas: chartsView[1])
        setCharts(with: dicc["sixMonthly"]!, canvas: chartsView[2])
        setCharts(with: dicc["year"]!, canvas: chartsView[3])
    }
    
    private func setupSubviews() {
        addSubview(chartsView[0])
        addSubview(chartsView[1])
        addSubview(chartsView[2])
        addSubview(chartsView[3])
        addSubview(buttonStackView)
        chartsView[0].addSubview(loader)
        
        NSLayoutConstraint.activate([
            chartsView[0].leadingAnchor.constraint(equalTo: leadingAnchor),
            chartsView[0].trailingAnchor.constraint(equalTo: trailingAnchor),
            chartsView[0].topAnchor.constraint(equalTo: topAnchor),
            chartsView[0].heightAnchor.constraint(equalTo: chartsView[0].widthAnchor, multiplier: 26/36),
            
            chartsView[1].leadingAnchor.constraint(equalTo: leadingAnchor),
            chartsView[1].trailingAnchor.constraint(equalTo: trailingAnchor),
            chartsView[1].topAnchor.constraint(equalTo: topAnchor),
            chartsView[1].heightAnchor.constraint(equalTo: chartsView[0].widthAnchor, multiplier: 26/36),
            
            chartsView[2].leadingAnchor.constraint(equalTo: leadingAnchor),
            chartsView[2].trailingAnchor.constraint(equalTo: trailingAnchor),
            chartsView[2].topAnchor.constraint(equalTo: topAnchor),
            chartsView[2].heightAnchor.constraint(equalTo: chartsView[0].widthAnchor, multiplier: 26/36),
            
            chartsView[3].leadingAnchor.constraint(equalTo: leadingAnchor),
            chartsView[3].trailingAnchor.constraint(equalTo: trailingAnchor),
            chartsView[3].topAnchor.constraint(equalTo: topAnchor),
            chartsView[3].heightAnchor.constraint(equalTo: chartsView[0].widthAnchor, multiplier: 26/36),
            
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonStackView.topAnchor.constraint(equalTo: chartsView[0].bottomAnchor, constant: 40),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: chartsView[0].centerYAnchor, constant: -20)
        ])
        
        addButtons(for: ["W", "M", "6M", "Y"])
    }
    
    private func addButtons(for titles: [String]) {
        titles.enumerated().forEach { (index, title ) in
            let button = UIButton()
            button.tag = index
            button.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 12)
            button.layer.cornerRadius = 12
            button.layer.cornerCurve = .continuous
            button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
            buttonStackView.addArrangedSubview(button)
            
            if button.tag == 0 {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
                
            } else {
                button.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            }
        }
    }
    
    @objc private func periodButtonTapped(sender: UIButton) {
        buttonStackView.subviews.compactMap { $0 as? UIButton }.forEach { button in
            button.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            button.setTitleColor(.black, for: .normal)
        }
        
        switch sender.tag {
        case 0:
            chartsView[0].alpha = 1
            chartsView[1...3].forEach { chartView in
                chartView.alpha = 0
            }
        case 1:
            chartsView[1].alpha = 1
            chartsView[0].alpha = 0
            chartsView[2...3].forEach { chartView in
                chartView.alpha = 0
            }
        case 2:
            chartsView[2].alpha = 1
            chartsView[3].alpha = 0
            chartsView[0...1].forEach { chartView in
                chartView.alpha = 0
            }
        case 3:
            chartsView[3].alpha = 1
            chartsView[0...2].forEach { chartView in
                chartView.alpha = 0
            }
        default:
            chartsView[0].alpha = 1
        }
        
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    private func setCharts(with prices: [Double]?, canvas: LineChartView) {
        guard let prices = prices else {
            return
        }
        
        var yValues = [ChartDataEntry]()
        for (index, value) in prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index+1), y: value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: "Prices Data")
        lineDataSet.fillColor = .lightGray
        lineDataSet.setColor(.black)
        lineDataSet.drawValuesEnabled = false
        lineDataSet.drawFilledEnabled = true
        lineDataSet.drawIconsEnabled = false
        lineDataSet.drawCirclesEnabled = false
    
        canvas.data = LineChartData(dataSets: [lineDataSet])
    }
}


extension ChartsContainerView: ChartViewProtocol {
    func updateChartView(with chartModel: ChartModel) {
        configureChart(with: chartModel)
    }
    
    func updateChartView(withLoader isLoading: Bool) {
        configure(with: isLoading)
    }
    
    func updateChartView(withError message: String) {
        
    }
}
