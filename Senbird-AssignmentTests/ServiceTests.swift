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
    
    func testSearchAPI() {
        let networkManager = NetworkManagerStub()
        let service = Service(networkManager: networkManager)
        
        service.search(keyword: "mongodb",
                       completionHandler: { _ in })
        
        let expectedURL = "https://api.itbook.store/1.0/search/mongodb"
        let actualURL = networkManager.lastURL
        XCTAssertEqual(actualURL, expectedURL)
    }
}
