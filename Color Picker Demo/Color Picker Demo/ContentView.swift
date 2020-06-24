//
//  ContentView.swift
//  Color Picker Demo
//
//  Created by Alejandrina Patron on 6/24/20.
//

import SwiftUI

struct ContentView: View {

  @State private var selectedColor = Color.black
  
  var body: some View {
    VStack(alignment: .center) {
      Text("Color Picker Demo").foregroundColor(selectedColor).font(.largeTitle)
      ColorPicker(
        "Pick a color",
        selection: $selectedColor
      ).frame(width: 150, height: 150)
      Spacer()
    }.padding(.vertical, 70)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
