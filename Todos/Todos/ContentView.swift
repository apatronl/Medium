//
//  ContentView.swift
//  Todos
//
//  Created by Alejandrina Patrón López on 8/25/20.
//  Copyright © 2020 Ale Patrón. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var newTodo = ""
  @State private var allTodos: [TodoItem] = []
  private let todosKey = "todosKey"
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          TextField("Add todo...", text: $newTodo)
            .textFieldStyle(RoundedBorderTextFieldStyle())

          Button(action: {
            guard !self.newTodo.isEmpty else { return }
            self.allTodos.append(TodoItem(todo: self.newTodo))
            self.newTodo = ""
            self.saveTodos()
          }) {
            Image(systemName: "plus")
          }
          .padding(.leading, 5)
        }.padding()

        List {
          ForEach(allTodos) { todoItem in
            Text(todoItem.todo)
          }.onDelete(perform: deleteTodo)
        }
      }
      .navigationBarTitle("Todos")
    }.onAppear(perform: loadTodos)
  }

  private func saveTodos() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allTodos), forKey: todosKey)
  }

  private func loadTodos() {
    if let todosData = UserDefaults.standard.value(forKey: todosKey) as? Data {
      if let todosList = try? PropertyListDecoder().decode(Array<TodoItem>.self, from: todosData) {
        self.allTodos = todosList
      }
    }
  }

  private func deleteTodo(at offsets: IndexSet) {
    self.allTodos.remove(atOffsets: offsets)
    saveTodos()
  }
}

struct TodoItem: Codable, Identifiable {
  let id = UUID()
  let todo: String
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
