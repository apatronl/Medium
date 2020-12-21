//
//  SongListViewModel.swift
//  Music Search
//
//  Created by Alejandrina Patron on 10/25/20.
//

import Combine
import Foundation

class SongListViewModel: ObservableObject {
  @Published var artistSearch: String = ""
  @Published public private(set) var songs: [Song] = []

  private var disposables = Set<AnyCancellable>()

  init() {
    $artistSearch
      .sink(receiveValue: loadSongs(forArtist:))
      .store(in: &disposables)
  }

  private func loadSongs(forArtist artist: String) {
    guard let url = buildUrl(forArtist: artist) else { return }

    URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else { return }
      if let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data) {
        DispatchQueue.main.async {
          self.songs = songResponse.songs
        }
      }
    }.resume()
  }

  private func buildUrl(forArtist artist: String) -> URL? {
    guard !artist.isEmpty else { return nil }

    let queryItems = [
      URLQueryItem(name: "term", value: artist),
      URLQueryItem(name: "entity", value: "song"),
    ]
    var urlComps = URLComponents(string: "https://itunes.apple.com/search")
    urlComps?.queryItems = queryItems

    return urlComps?.url
  }
}
