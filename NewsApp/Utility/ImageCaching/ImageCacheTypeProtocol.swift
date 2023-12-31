//
//  ImageCacheTypeProtocol.swift
//  NewsApp
//
//  Created by Durga Ballabha Panigrahi on 10/07/23.
//

import UIKit

protocol ImageCacheType: AnyObject {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages(completion: (_ isCompleted: Bool) -> Void)
    subscript(_ url: URL) -> UIImage? { get set }
}
