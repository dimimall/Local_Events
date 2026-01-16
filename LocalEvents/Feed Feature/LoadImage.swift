//
//  LoadImage.swift
//  Local Events
//
//  Created by Dimitra Malliarou on 14/1/26.
//

import Foundation
import UIKit

class LoadImage {
    private var imageCache: [URL: UIImage] = [:]


    func loadImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        
        if let image = imageCache[url] {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let image = image {
                    self?.imageCache[url] = image
                }
            }
            completion(image)
        }.resume()
    }
}
