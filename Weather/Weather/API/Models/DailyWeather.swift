//
//  DailyWeather.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

class DailyWeather: Codable {
  let lat: Double?
  let lon: Double?
  let hourly: [Hourly]?
  let daily: [Daily]?
  let current: Current?
}

class Hourly: Codable {
    let dt: TimeInterval
    let weather: [WeatherIcon]
    let temp: Double
}

class Daily: Codable {
  let dt: TimeInterval?
  let weather: [WeatherIcon]?
  let temp: Temperature?
}

class Current: Codable {
  let dt: TimeInterval?
  let weather: [WeatherIcon]?
  let temp: Double?
}

class WeatherIcon: Codable {
  let icon: String?
}

class Temperature: Codable {
  let min: Double?
  let max: Double?
}
