//
//  HomeViewController.swift
//  OMDB-API-Firebase
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import UIKit
import DataProvider
import TinyConstraints

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let tableView = UITableViewBuilder()
        .build()
    private let topView = HomeScreenTopView()

    private let refreshControl = UIRefreshControl()
    var filteredItems: [HomeCellProtocol] = []
    var searchText: String = ""
    var isSearchTextEmpty: Bool {
        return searchText.isEmpty
    }
    
    var isFiltering: Bool {
        return !isSearchTextEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModelEvents()
        searchButtonAction()
        tableView.keyboardDismissMode = .onDrag
    }

    private func subscribeViewModelEvents() {
        viewModel.didSuccessMovies = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.tableFooterView = nil
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        makeTableView()
        makeTopView()
    }
    
    private func makeTopView() {
        topView.width(UIScreen.main.bounds.width - 20)
    }
    
    private func makeTableView() {
        view.addSubview(tableView)
        tableView.topToSuperview()
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview()
    }
    
}

// MARK: - Configure
extension HomeViewController {
    
    private func configureContents() {
        view.backgroundColor = .white
        topView.searchTextField.delegate = self
        topView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.defaultReuseIdentifier)
        tableView.refreshControl = refreshControl
        self.navigationController?.navigationBar.topItem?.titleView = topView
    }
    
}

// MARK: - Actions
extension HomeViewController {
    
    private func searchButtonAction() {
        topView.searchTextFieldTapped = { [weak self] text in
            guard let self = self else { return }
            self.viewModel.fetchMoviesListing(title: text)
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionListSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rowCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.viewModel.sectionListSource[indexPath.section]
        switch data.type {
        case .empty:
            return HomeCell.createCell(data, tableView: tableView, indexPath: indexPath)
        case .item:
            return HomeCell.createCell(data, tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel.didSelectRow(indexPath: indexPath)
    }
  
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

