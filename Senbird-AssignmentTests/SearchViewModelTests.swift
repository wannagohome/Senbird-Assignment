//
//  SearchViewModelTests.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation
import XCTest
@testable import Senbird_Assignment

final class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModelProtocol!
    var networkManager: NetworkManagerStub!
    var service: Service!
    
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManagerStub()
        self.service = Service(networkManager: self.networkManager)
        self.viewModel = SearchViewModel(service: self.service)
    }
    
    func testSearch() {
        self.viewModel.search(with: "mongodb")
        
        let expectedURL = "https://api.itbook.store/1.0/search/mongodb"
        let actualURL = self.networkManager.lastURL
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testSearch_whenKeywordEmpty() {
        self.viewModel.search(with: nil)
        
        XCTAssertEqual(self.networkManager.lastURL, nil)
    }
}
