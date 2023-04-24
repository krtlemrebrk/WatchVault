//
//  CacheManager.swift
//  WatchVault
//
//  Created by Kartal Emre BURUK (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 23.04.2023.
//

import SwiftUI

class CacheManager {
    
    static let shared = CacheManager()
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Image named \(name) added to cache.")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Image named \(name) removed from cache.")
    }
    
    func get(name: String) -> UIImage? {
        guard let uiImage = imageCache.object(forKey: name as NSString) else {
            return nil
        }
        print("Image named \(name) returned from cache.")
        return uiImage
    }
}
