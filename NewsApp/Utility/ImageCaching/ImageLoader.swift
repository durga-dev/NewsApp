//
//  ImageLoader.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import UIKit
import Combine

public final class ImageLoader {
    private let cache = ImageCache()
    
    private let backgroundQueue = DispatchQueue(label: "com.news.imageDownload", qos: .background)
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[weak self] image in
                guard let image = image else { return }
                self?.cache[url] = image
            })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
