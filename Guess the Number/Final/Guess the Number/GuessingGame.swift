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
  
  private(set) var gameStatus: GameStatus
  private var numberOfGuesses: Int

  init(elementToGuess: GuessElement, maxGuesses: Int) {
    self.elementToGuess = elementToGuess
    self.maxGuesses = maxGuesses
    gameStatus = .playing
    numberOfGuesses = 0
  }

  mutating func makeGuess(withElement element: GuessElement) {
    numberOfGuesses += 1
    if element == elementToGuess {
      gameStatus = .won
    } else if numberOfGuesses >= maxGuesses {
      gameStatus = .lost
    } else {
      gameStatus = .playing
    }
  }

  mutating func reset(with elementToGuess: GuessElement) {
    self.elementToGuess = elementToGuess
    numberOfGuesses = 0
  }
}
