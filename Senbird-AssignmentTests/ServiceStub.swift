//
//  ServiceStub.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation
@testable import Senbird_Assignment

final class ServiceStub: ServiceProtocol {
    var lastKeyword: String?
    
    func search(keyword: String,
                completionHandler: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        self.lastKeyword = keyword
    }
}
