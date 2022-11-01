//
//  CurrentWeather.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

class CurrentWeather: Codable {
  let coord: Coordinat?
  let weather: [Weather]?
  let main: Main?
  let wind: Wind?
  let dt: TimeInterval
  let sys: Sys?
  let timezone: Int?
  let name: String?
}

class Coordinat: Codable {
  let lon: Double?
  let lat: Double?
}

class Weather: Codable {
  let id: Int?
  let description: String?
  let icon: String?
}

class Main: Codable {
  let temp: Double?
  let feelsLike: Double?
  let tempMin: Double?
  let tempMax: Double?
  let pressure: Double?
  let humidity: Double?
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
  }
}

class Wind: Codable {
  let speed: Double
}

class Sys: Codable {
  let country: String?
}
