//
//  ImageCache+ImageCacheType.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import UIKit

// MARK: ImageCache+ImageCacheType
extension ImageCache: ImageCacheType {
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()

        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache.setObject(decodedImage, forKey: url as AnyObject)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
    }

    func removeImage(for url: URL) {
        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func image(for url: URL) -> UIImage? {
        lock.lock()
        defer {
            lock.unlock()
        }
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
            return decodedImage
        }
        return nil
    }
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
    
    func removeAllImages(completion: (_ isCompleted: Bool) -> Void) {
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
        completion(true)
    }
}
