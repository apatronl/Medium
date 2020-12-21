//
//  ImageLoader.swift
//  Music Search
//
//  Created by Alejandrina Patron on 10/25/20.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
  @Published public private(set) var image: Image?

  private var dataTask: URLSessionDataTask?
  private let keyPrefix = "artwork-"

  deinit {
    dataTask?.cancel()
  }

  func loadImage(forSong song: Song) {
    if let cachedImage = ImageCache.shared.getValue(forKey: "\(keyPrefix)\(song.id)") {
      DispatchQueue.main.async {
        self.image = Image(uiImage: cachedImage)
        return
      }
    }

    guard let imageUrl = URL(string: song.artworkUrl) else { return }
    dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
      guard let data = data else { return }
      guard let remoteImage = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        self.image = Image(uiImage: remoteImage)
        ImageCache.shared.setValue(remoteImage, forKey: "\(self.keyPrefix)\(song.id)")
      }
    }
    dataTask?.resume()
  }
}
