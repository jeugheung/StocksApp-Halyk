//
//  SearchView.swift
//  Stocks-app-Halyk
//
//  Created by Andrey Kim on 10.06.2022.
//

import Foundation
import UIKit

final class SearchView: UIViewController {
    
    private let presenter: SearchPresenterProtocol
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        return tableView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var searchViewContainer: UIView = {
        let searchViewContainer = UIView()
        searchViewContainer.translatesAutoresizingMaskIntoConstraints = false
        searchViewContainer.layer.borderWidth = 2
        searchViewContainer.layer.borderColor = UIColor.black.cgColor
        searchViewContainer.layer.cornerRadius = 25
        return searchViewContainer
    }()
    
    private lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.placeholder = "Search crypto symbol or name"
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.addTarget(self, action: #selector(SearchView.textFieldDidChange(_:)), for: .editingChanged)
        searchTextField.delegate = self
        return searchTextField
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteTextSearch), for: .touchUpInside)
        deleteButton.setImage(UIImage(named: "delete.pdf"), for: .normal)
        return deleteButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSubviews()
        setupConstraints()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter.searchStocks(searcher: textField.text)
    }
    
    @objc func deleteTextSearch() {
        searchTextField.text = nil
        presenter.searchStocks(searcher: nil)
        tableView.reloadData()
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(containerView)
        containerView.addSubview(searchViewContainer)
        searchViewContainer.addSubview(searchTextField)
        searchViewContainer.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            searchViewContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 7),
            searchViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            searchViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            searchViewContainer.heightAnchor.constraint(equalToConstant: 45),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchViewContainer.leadingAnchor, constant: 15),
            searchTextField.topAnchor.constraint(equalTo: searchViewContainer.topAnchor, constant: 11),
            searchTextField.widthAnchor.constraint(equalToConstant: 280),
            
            deleteButton.topAnchor.constraint(equalTo: searchViewContainer.topAnchor, constant: 11),
            deleteButton.trailingAnchor.constraint(equalTo: searchViewContainer.trailingAnchor, constant: -15),
            deleteButton.bottomAnchor.constraint(equalTo: searchViewContainer.bottomAnchor, constant: -11)
        ])
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Search"
    }
}

extension SearchView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else {
            return UITableViewCell()
        }
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = presenter.model(for: indexPath)
        let detailVC = Assembly.assembler.detailVC(for: model)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension SearchView: SearchViewProtocol {
    func updateView() {
        tableView.reloadData()
    }

    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func updateView(withLoader isLoading: Bool) {
        
    }

    func updateView(withError message: String) {
        
    }
}
