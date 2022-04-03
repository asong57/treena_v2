//
//  ImageCacheManager.swift
//  treena_v2
//
//  Created by asong on 2022/04/03.
//

import UIKit

class ImageCacheManager{
    static let shared = NSCache<NSString, UIImage>()
    private init(){}
}
