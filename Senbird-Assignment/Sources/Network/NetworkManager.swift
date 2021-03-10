//
//  NetworkManager.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(with urlString: String,
                 completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    let session = URLSession.shared
    
    func request(with urlString: String,
                 completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = self.session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
        
        dataTask.resume()
    }
}
