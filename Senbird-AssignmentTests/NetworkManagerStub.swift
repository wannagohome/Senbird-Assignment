//
//  NetworkManagerStub.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation
@testable import Senbird_Assignment

final class NetworkManagerStub: NetworkManagerProtocol {
    var lastURL: String?
    
    func request(with urlString: String,
                 completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        self.lastURL = urlString
    }
}
