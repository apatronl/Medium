//
//  ImageCache.swift
//  Music Search
//

import UIKit

class ImageCache {
  public static var shared = ImageCache()

  private var cache = NSCache<NSString, UIImage>()

  func getValue(forKey key: String) -> UIImage? {
    return cache.object(forKey: NSString(string: key))
  }

  func setValue(_ image: UIImage, forKey key: String) {
    cache.setObject(image, forKey: NSString(string: key))
  }
}
