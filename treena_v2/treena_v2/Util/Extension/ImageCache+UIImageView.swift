//
//  ImageCache+UIImageView.swift
//  treena_v2
//
//  Created by asong on 2022/04/03.
//

import UIKit

extension UIImageView{
    func setImageWithUrl(_ url: String){
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey){
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let _ = error {
                        print("url image download error happened")
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}
