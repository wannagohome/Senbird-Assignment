//
//  BookDetailViewModelTests.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/12.
//

import Foundation
import XCTest
@testable import Senbird_Assignment

final class BookDetailViewModelTests: XCTestCase {
    var viewModel: BookDetailViewModelProtocol!
    var networkManager: NetworkManagerStub!
    var service: Service!
    
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManagerStub()
        self.service = Service(networkManager: self.networkManager)
        self.viewModel = BookDetailViewModel(service: self.service,
                                             state: .init(isbn13: "123"))
    }
    
    func testGetDtail() {
        let expectedURL = "https://api.itbook.store/1.0/books/123"
        let actualURL = self.networkManager.lastURL
        XCTAssertEqual(actualURL, expectedURL)
    }
}
