//
//  BookDetail.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

struct BookDetail: Decodable {
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn10: String
    let isbn13: String
    let pages: String
    let year: String
    let rating: String
    let desc: String
    let price: String
    let image: String
    let url: String
    
    var description: String {
        """
        Title : \(title)
        Subtitle : \(subtitle)
        Authors : \(authors)
        Publisher : \(publisher)
        Pages : \(pages)
        Year : \(year)
        Rating : \(rating)
        isbn13 : \(isbn13)
        Price : \(price)
        URL: \(url)

        Description : \(desc)
        """
    }
}
