//
//  GuessingGame.swift
//  Guess the Number
//
//  Created by Alejandrina Patrón López on 7/25/20.
//  Copyright © 2020 Alejandrina Patrón López. All rights reserved.
//

import Foundation

// Model
struct GuessingGame<GuessElement: Equatable> {
  enum GameStatus {
    case won
    case lost
    case playing
  }

  var elementToGuess: GuessElement
  var maxGuesses: Int

  // TODO
//  private(set) var gameStatus: GameStatus
//  private var numberOfGuesses: Int

  mutating func makeGuess(withElement element: GuessElement) {
    // TODO
  }

  mutating func reset(with elementToGuess: GuessElement) {
    // TODO
  }
}
