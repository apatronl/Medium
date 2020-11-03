//
//  Tweet.swift
//  TwitterUI
//
//  Created by Alejandrina Patrón López on 11/1/20.
//

import Foundation

struct Tweet: Identifiable {
  let id = UUID()
  let authorName: String
  let authorUsername: String
  let timestampText: String
  let text: String
  let numberOfReplies: Int
  let numberOfRetweets: Int
  let numberOfLikes: Int
}
