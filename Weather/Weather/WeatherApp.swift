//
//  WeatherApp.swift
//  Weather
//

import SwiftUI

@main
struct WeatherApp: App {
  var body: some Scene {
    WindowGroup {
      let weatherService = WeatherService()
      WeatherView(viewModel: WeatherViewModel(weatherService: weatherService))
    }
  }
}
