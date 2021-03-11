//
//  SearchViewControllerTests.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation
import XCTest
@testable import Senbird_Assignment

final class SearchViewControllerTests: XCTestCase {
    var viewModel: SearchViewModel!
    var viewController: SearchViewController!
    var networkManager: NetworkManagerStub!
    var service: Service!
    
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManagerStub()
        self.service = Service(networkManager: self.networkManager)
        self.viewModel = SearchViewModel(service: self.service)
        self.viewController = SearchViewController(viewModel: self.viewModel)
        self.viewController.loadViewIfNeeded()
    }
    
    func testTableView_configureRepositoryCell_afterSearching() {
        let searchBar = self.viewController.searchController.searchBar
        searchBar.text = "mongodb"
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        
        let books = [
            BookSearch(title: "mongodbA", subtitle: "mongodbA", isbn13: "123", price: "123", image: "mongodbA", url: "mongodbA")
        ]
        let searchResult = SearchResult(total: "1", error: "0", page: "1", books: books)
        self.viewModel.state.searchResult = searchResult
        self.viewController.reloadTable()
        
        let numberOfRows = self.viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        let cell = self.viewController.tableView(self.viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "mongodbA")
    }
}
