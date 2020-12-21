//
//  Music_SearchApp.swift
//  Music Search
//
//  Created by Alejandrina Patron on 10/21/20.
//

import SwiftUI

@main
struct Music_SearchApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: SongListViewModel())
    }
  }
}
