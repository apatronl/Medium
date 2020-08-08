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
    VStack {
      Text(self.gameViewModel.guessLabel)
      TextField(
        "Type a number",
        text: self.$gameViewModel.currentGuess
      )
      .keyboardType(.numberPad)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .multilineTextAlignment(.center)

      Button(
        "Enter guess",
        action: {
          if let userGuess = Int(self.gameViewModel.currentGuess) {
            self.gameViewModel.makeGuess(withNumber: userGuess)
          }
        }
      ).alert(isPresented: $gameViewModel.showAlert) {
        return Alert(
          title: Text(self.gameViewModel.alertTitle),
          message: nil,
          dismissButton: .default(Text("Start new game"), action: {
            self.gameViewModel.reset()
          })
        )
      }
    }.padding()
  }
}
