//
//  NetworkError.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//


enum NetworkError: Error {
    case noData
    case urlError
    case castingError
    case noBooks
    
    var message: String {
        switch self {
        case .noData:
            return "Empty Data"
        case .urlError:
            return "Wrong URL"
        case .castingError:
            return "Fail to Casting"
        case .noBooks:
            return "Books not found"
        }
    }
}
