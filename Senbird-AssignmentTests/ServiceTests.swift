//
//  ServiceTests.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation
import XCTest
@testable import Senbird_Assignment

final class ServiceTests: XCTestCase {
    var networkManager: NetworkManagerStub!
    var service: Service!
    
    override func setUp() {
        self.networkManager = NetworkManagerStub()
        self.service = Service(networkManager: networkManager)
    }
    
    func testSearchAPI() {
        self.service.search(keyword: "mongodb",
                       completionHandler: { _ in })
        
        let expectedURL = "https://api.itbook.store/1.0/search/mongodb/1"
        let actualURL = self.networkManager.lastURL
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testDetailAPI() {
        self.service.getDetail(isbn13: "123",
                               completionHandler: { _ in })
        
        let expectedURL = "https://api.itbook.store/1.0/books/123"
        let actualURL = self.networkManager.lastURL
        XCTAssertEqual(actualURL, expectedURL)
    }
}
