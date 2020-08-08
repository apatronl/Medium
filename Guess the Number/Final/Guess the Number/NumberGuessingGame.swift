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

  private var model: GuessingGame<Int>
  private var maxGuesses = 3

  init() {
    model = GuessingGame(elementToGuess: NumberGuessingGame.generateGuess(), maxGuesses: maxGuesses)
  }

  func makeGuess(withNumber number: Int) {
    model.makeGuess(withElement: number)
    switch model.gameStatus {
    case .lost:
      alertTitle = "You lost! 😢"
      showAlert = true
      guessLabel = "Guess the Number!"
    case .won:
      alertTitle = "You won! 🥳"
      showAlert = true
      guessLabel = "Guess the Number!"
    case .playing:
      guessLabel = "Try again!"
    }
    currentGuess = ""
  }

  func reset() {
    model.reset(with: NumberGuessingGame.generateGuess())
    showAlert = false
  }

  private static func generateGuess() -> Int {
    return Int.random(in: 1...10)
  }
}
