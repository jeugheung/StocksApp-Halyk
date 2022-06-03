//
//  FavoriteViewController.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 01.06.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private var presenter: FavoritePresenterProtocol
    
    init(presenter: FavoritePresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.typeName)
        return tableView
    }()
    
    private let colorForOCell = UIColor(r: 240, g: 244, b: 247)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.loadView()
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Favorites"
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.typeName, for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        if indexPath.row.isMultiple(of: 2) {
            cell.cellView.backgroundColor = colorForOCell
        } else {
            cell.cellView.backgroundColor = .white
        }
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.model(for: indexPath)
        let detailVC = ModuleBuilder.shared.detailVC(for: model)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    
    
    func updateView() {
        tableView.reloadData()
    }
    
    
    func updateView(withLoader isLoading: Bool) {
        print(isLoading, "true")
    }
    
    func updateView(withError message: String) {
        print(message, "error")
    }
}
