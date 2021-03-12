//
//  Service.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

protocol ServiceProtocol {
    func search(keyword: String,
                page: Int,
                completionHandler: @escaping (Result<SearchResult, NetworkError>) -> Void)
    func getDetail(isbn13: String,
                   completionHandler: @escaping (Result<BookDetail, NetworkError>) -> Void)
}

extension ServiceProtocol {
    func search(keyword: String,
                page: Int = 1,
                completionHandler: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        self.search(keyword: keyword, page: page, completionHandler: completionHandler)
    }
}


final class Service: ServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func search(keyword: String,
                page: Int = 1,
                completionHandler: @escaping (Result<SearchResult, NetworkError>) -> Void) {
        let urlString = "https://api.itbook.store/1.0/search/\(keyword)/\(page)"
        self.request(urlString: urlString,
                     decodeType: SearchResult.self,
                     completionHandler: completionHandler)
    }
    
    func getDetail(isbn13: String,
                   completionHandler: @escaping (Result<BookDetail, NetworkError>) -> Void) {
        let urlString = "https://api.itbook.store/1.0/books/\(isbn13)"
        self.request(urlString: urlString,
                     decodeType: BookDetail.self,
                     completionHandler: completionHandler)
    }
    
    private func request<E: Decodable>(urlString: String,
                            decodeType: E.Type,
                            completionHandler: @escaping (Result<E, NetworkError>) -> Void) {
        self.networkManager.request(with: urlString) { result in
            switch result {
            case .success(let data):
                if let searchResult = try? JSONDecoder().decode(E.self, from: data) {
                    completionHandler(.success(searchResult))
                } else {
                    completionHandler(.failure(.castingError))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
