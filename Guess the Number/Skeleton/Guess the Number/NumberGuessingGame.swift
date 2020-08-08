//
//  NumberGuessingGame.swift
//  Guess the Number
//
//  Created by Alejandrina Patrón López on 7/25/20.
//  Copyright © 2020 Alejandrina Patrón López. All rights reserved.
//

import Foundation

// ViewModel
class NumberGuessingGame: ObservableObject {
  
  @Published var currentGuess = ""
  @Published var showAlert = false
  @Published var alertTitle = ""
  @Published var guessLabel = "Guess the number!"

//  private var model: GuessingGame<Int>
//  private var maxGuesses = 3

  func makeGuess(withNumber number: Int) {
    // TODO
  }

  func reset() {
    // TODO
  }

  private static func generateGuess() -> Int {
    // TODO
    return 1
  }
}
