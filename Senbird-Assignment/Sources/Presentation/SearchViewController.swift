//
//  SearchViewController.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

class SearchViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .grouped)
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupLayout()
    }
    
    private func setupTableView() {
        
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

