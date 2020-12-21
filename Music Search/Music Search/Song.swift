//
//  Song.swift
//  Music Search
//
//  Created by Alejandrina Patron on 10/21/20.
//

import Foundation
import UIKit

struct SongResponse: Decodable {
  var songs: [Song]

  enum CodingKeys: String, CodingKey {
    case songs = "results"
  }
}

struct Song: Decodable, Identifiable {
  let id: Int
  let trackName: String
  let artistName: String
  let artworkUrl: String

  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case trackName
    case artistName
    case artworkUrl = "artworkUrl60"
  }
}
