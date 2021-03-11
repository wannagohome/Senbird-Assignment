//
//  SearchViewController.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

protocol SearchViewControllable: class {
    func showAlert(with title: String)
    func reloadTable()
}

final class SearchViewController:
    UIViewController,
    SearchViewControllable {
    
    var viewModel: SearchViewModel?
    let tableView = UITableView(frame: .zero, style: .grouped)
    let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        defer {
            self.viewModel?.viewControllable = self
        }
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController.searchBar.delegate = self
        self.setupTableView()
        self.setupLayout()
    }
    
    func showAlert(with title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "dismiss", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        self.tableView.dataSource = self
    }
    
    private func setupLayout() {
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = self.searchController
        } else {
            self.tableView.tableHeaderView = self.searchController.searchBar
        }
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.state.searchResult?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = self.viewModel?.state.searchResult?.books[indexPath.row].title
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.search(with: searchBar.text)
    }
}
