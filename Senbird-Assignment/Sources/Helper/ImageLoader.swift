//
//  ImageLoader.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

final class ImageLoader {
    
    public static let shared = ImageLoader()
    private let cachedImages = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    final func load(url: NSURL, completion: @escaping (UIImage) -> Void) {
        
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first,
              let lastPath = url.lastPathComponent else {
            return
        }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(lastPath)
        if fileManager.fileExists(atPath: filePath.path),
           let imageData = try? Data(contentsOf: filePath),
           let cachedImage = UIImage(data: imageData) {
            completion(cachedImage)
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url as URL) {
                if let image = UIImage(data: data) {
                    self.cachedImages.setObject(image, forKey: url, cost: data.count)
                    self.fileManager.createFile(atPath: filePath.path, contents: data, attributes: nil)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}
