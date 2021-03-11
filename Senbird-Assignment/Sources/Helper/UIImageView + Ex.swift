//
//  UIImageView + Ex.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        ImageLoader.shared.load(url: url as NSURL) { [weak self] image in
            self?.image = image
        }
    }
}
