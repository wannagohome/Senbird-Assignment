//
//  BookSearch.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

struct BookSearch: Decodable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
    
    var description: String {
        """
        Title : \(title)
        Subtitle : \(subtitle)
        isbn13 : \(isbn13)
        Price : \(price)
        URL: \(url)
        """
    }
}

struct SearchResult: Decodable {
    let total: String
    let error: String
    let page: String?
    var books: [BookSearch]
}
