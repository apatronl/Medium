//
//  ContentView.swift
//  Guess the Number
//
//  Created by Alejandrina Patrón López on 7/19/20.
//  Copyright © 2020 Alejandrina Patrón López. All rights reserved.
//

import SwiftUI

struct NumberGuessingGameView: View {

  @ObservedObject private var gameViewModel: NumberGuessingGame

  public init(gameViewModel: NumberGuessingGame) {
    self.gameViewModel = gameViewModel
  }

  var body: some View {
    // TODO
    EmptyView()
  }
}
