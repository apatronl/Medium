//
//  ViewController.swift
//  Programming Quotes UIKit
//
//  Created by Ale Patrón on 11/11/20.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var label: UILabel = {
    let view = UILabel(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.numberOfLines = 0
    view.text = "Hello world!"
    return view
  }()

  private lazy var refreshButton: UIButton = {
    let button = UIButton(frame: .zero)
    let image = UIImage(systemName: "arrow.clockwise")
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private var joke: Joke? {
    didSet {
      guard let joke = joke else { return }
      label.text = "\(joke.setup)\n\(joke.punchline)"
      label.sizeToFit()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Label and button setup
    view.addSubview(label)
    view.addSubview(refreshButton)
    addConstraints()

    // Get joke from API
    loadData()
  }

  private func addConstraints() {
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    refreshButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
    refreshButton.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
  }

 @objc private func loadData() {
    guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      if let decodedData = try? JSONDecoder().decode(Joke.self, from: data) {
        DispatchQueue.main.async {
          self.joke = decodedData
        }
      }
    }.resume()
  }
}

struct Joke: Decodable {
  var id: Int
  var type: String
  var setup: String
  var punchline: String
}
