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
    private let networkManager: NetworkManagerStub
    
    init(networkManager: NetworkManagerStub) {
        self.networkManager = networkManager
    }
    
    func search(keyword: String,
                page: Int = 1,
                completionHandler: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        self.lastKeyword = keyword
        let urlString = "https://api.itbook.store/1.0/search/\(keyword)/\(page)"
        self.networkManager.request(with: urlString) { _ in
            completionHandler(.success(
                                .init(total: "1", error: "0", page: "1",
                                      books:
                                        [
                                            .init(title: keyword, subtitle: "", isbn13: "", price: "", image: "", url: "")
                                        ])))
        }
        
    }
    
    func getDetail(isbn13: String,
                   completionHandler: @escaping (Result<BookDetail, NetworkError>) -> Void) {
        self.lastKeyword = isbn13
        let urlString = "https://api.itbook.store/1.0/books/\(isbn13)"
        self.networkManager.request(with: urlString) { _ in
            completionHandler(.success(.init(error: "0", title: isbn13, subtitle: "", authors: "", publisher: "", isbn10: "", isbn13: "", pages: "", year: "", rating: "", desc: "", price: "", image: "", url: "")))
        }
    }
}
