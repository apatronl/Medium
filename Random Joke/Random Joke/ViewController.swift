//
//  ViewController.swift
//  Random Joke
//
//  Created by Alejandrina Patrón López on 12/14/20.
//

import UIKit

class ViewController: UIViewController {
  
  private lazy var label: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Loading joke..."
    label.sizeToFit()
    return label
  }()
  
  private lazy var refreshButton: UIButton = {
    let button = UIButton(frame: .zero)
    let image = UIImage(systemName: "arrow.clockwise")
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private var dataTask: URLSessionDataTask?
  
  private var joke: Joke? {
    didSet {
      guard let joke = joke else { return }
      label.text = "\(joke.setup)\n\(joke.punchline)"
      label.sizeToFit()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.addSubview(label)
    view.addSubview(refreshButton)
    setConstraints()
    
    loadData()
  }
  
  private func setConstraints() {
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    refreshButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
    refreshButton.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
  }

  @objc private func loadData() {
    guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
      return
    }
    
    dataTask?.cancel()
    dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      if let decodedData = try? JSONDecoder().decode(Joke.self, from: data) {
        DispatchQueue.main.async {
          self.joke = decodedData
        }
      }
    }
    dataTask?.resume()
  }
}

struct Joke: Decodable {
  let id: Int
  let type: String
  let setup: String
  let punchline: String
}
