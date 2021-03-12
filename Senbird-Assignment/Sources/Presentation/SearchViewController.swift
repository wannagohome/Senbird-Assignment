//
//  SearchViewController.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

protocol SearchViewControllable: class {
    func showAlert(with title: String, completionHandler: (() -> Void)?)
    func reloadTable()
}

extension SearchViewControllable {
    func showAlert(with title: String, completionHandler: (() -> Void)? = nil) {
        self.showAlert(with: title, completionHandler: completionHandler)
    }
}

final class SearchViewController:
    UIViewController,
    SearchViewControllable {
    
    var viewModel: SearchViewModelProtocol?
    let tableView = UITableView(frame: .zero, style: .grouped)
    let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: SearchViewModelProtocol = SearchViewModel()) {
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
    
    func showAlert(with title: String,
                   completionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "dismiss", style: .default)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: completionHandler)
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.register(SearchResultCell.self,
                                forCellReuseIdentifier: SearchResultCell.description())
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.description(), for: indexPath) as! SearchResultCell
        cell.label.numberOfLines = 0
        cell.label.text = self.viewModel?.state.searchResult?.books[indexPath.row].description
        cell.bookImage.load(url: self.viewModel?.state.searchResult?.books[indexPath.row].image ?? "")
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let isbn13 = self.viewModel?.state.searchResult?.books[indexPath.row].isbn13 {
            let state = BookDetailViewState(isbn13: isbn13)
            let vm = BookDetailViewModel(state: state)
            let vc = BookDetailViewController(viewModel: vm)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.search(with: searchBar.text)
        self.searchController.dismiss(animated: true)
    }
}
