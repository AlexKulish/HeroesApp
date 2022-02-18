//
//  ImageCache.swift
//  HeroesApp
//
//  Created by Alex Kulish on 18.02.2022.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
