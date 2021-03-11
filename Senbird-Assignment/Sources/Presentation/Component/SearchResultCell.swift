//
//  SearchResultCell.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    let bookImage = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLaytout()
        self.label.font = .systemFont(ofSize: 13)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLaytout() {
        self.contentView.addSubview(self.bookImage)
        self.contentView.addSubview(self.label)
        self.bookImage.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        self.bookImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.bookImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.bookImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.bookImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.label.topAnchor.constraint(equalTo: self.bookImage.topAnchor).isActive = true
        self.label.leadingAnchor.constraint(equalTo: self.bookImage.trailingAnchor, constant: 5).isActive = true
        self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
}
