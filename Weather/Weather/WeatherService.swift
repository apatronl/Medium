//
//  WeatherService.swift
//  Weather
//

import CoreLocation
import Foundation

// Sample URL:
// https://api.openweathermap.org/data/2.5/weather?lat=51.50998&lon=-0.1337&appid=e6f124ac6b7d2fea7347932c86883958&units=metric

public final class WeatherService: NSObject {

  private let locationManager = CLLocationManager()
  private let API_KEY = "133a4def891130e5c5bc762d902fca52"
  private var completionHandler: ((Weather?, LocationAuthError?) -> Void)?
  private var dataTask: URLSessionDataTask?

  public override init() {
    super.init()
    locationManager.delegate = self
  }

  public func loadWeatherData(
    _ completionHandler: @escaping((Weather?, LocationAuthError?) -> Void)
  ) {
    self.completionHandler = completionHandler
    loadDataOrRequestLocationAuth()
  }

  private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
    guard let urlString =
      "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let url = URL(string: urlString) else { return }

    // Cancel previous task
    dataTask?.cancel()

    dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      guard error == nil, let data = data else { return }
  
      if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
        self.completionHandler?(Weather(response: response), nil)
      }
    }
    dataTask?.resume()
  }
  
  private func loadDataOrRequestLocationAuth() {
    switch locationManager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
    case .denied, .restricted:
      completionHandler?(nil, LocationAuthError())
    default:
      locationManager.requestWhenInUseAuthorization()
    }
  }
}

extension WeatherService: CLLocationManagerDelegate {
  public func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    makeDataRequest(forCoordinates: location.coordinate)
  }

  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    loadDataOrRequestLocationAuth()
  }
  public func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print("Something went wrong: \(error.localizedDescription)")
  }
}

struct APIResponse: Decodable {
  let name: String
  let main: APIMain
  let weather: [APIWeather]
}

struct APIMain: Decodable {
  let temp: Double
}

struct APIWeather: Decodable {
  let description: String
  let iconName: String
  
  enum CodingKeys: String, CodingKey {
    case description
    case iconName = "main"
  }
}

public struct LocationAuthError: Error {}
