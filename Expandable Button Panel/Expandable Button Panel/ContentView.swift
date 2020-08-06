//
//  ContentView.swift
//  Expandable Button Panel
//
//  Created by Alejandrina Patrón López on 8/4/20.
//  Copyright © 2020 Ale Patrón. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  @State private var showAlert: Bool = false
  @State private var alertLabel: String = ""

  var body: some View {
    NavigationView {
      ZStack {
        // List
        List(1...20, id: \.self) { i in
          Text("Item #\(i)")
            .padding()
        }

        // Floating Button Panel
        VStack {
          Spacer()
          HStack {
            Spacer()
            ExpandableButtonPanel(
              primaryItem: ExpandableButtonItem(label: "➕"),
              secondaryItems: [
                ExpandableButtonItem(label: "🌞") {
                  self.alertLabel = "🌞"
                  self.showAlert.toggle()
                },
                ExpandableButtonItem(label: "🥑") {
                  self.alertLabel = "🥑"
                  self.showAlert.toggle()
                }
              ]
            )
            .padding()
          }
        }
      }
      .alert(isPresented: $showAlert) {
        return Alert(title: Text("You selected \(self.alertLabel)"))
      }
      .navigationBarTitle("Numbers")
    }
  }
}

struct ExpandableButtonItem: Identifiable {
  let id = UUID()
  let label: String
  private(set) var action: (() -> Void)? = nil
}

struct ExpandableButtonPanel: View {

  let primaryItem: ExpandableButtonItem
  let secondaryItems: [ExpandableButtonItem]

  private let noop: () -> Void = {}
  private let size: CGFloat = 70
  private var cornerRadius: CGFloat {
    get { size / 2 }
  }
  private let shadowColor = Color.black.opacity(0.4)
  private let shadowPosition: (x: CGFloat, y: CGFloat) = (x: 2, y: 2)
  private let shadowRadius: CGFloat = 3

  @State private var isExpanded = false

  var body: some View {
    VStack {
      ForEach(secondaryItems) { item in
        Button(item.label, action: item.action ?? self.noop)
          .frame(
            width: self.isExpanded ? self.size : 0,
            height: self.isExpanded ? self.size : 0)
      }

      Button(primaryItem.label, action: {
        withAnimation {
          self.isExpanded.toggle()
        }
        self.primaryItem.action?()
      })
      .frame(width: size, height: size)
    }
    .background(Color(UIColor.systemPurple))
    .cornerRadius(cornerRadius)
    .font(.title)
    .shadow(
      color: shadowColor,
      radius: shadowRadius,
      x: shadowPosition.x,
      y: shadowPosition.y
    )
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
