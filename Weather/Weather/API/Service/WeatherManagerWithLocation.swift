//
//  WeatherManagerWithLocation.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

enum WeatherError: Error {
  case serverSideError
  case decodingError
}

class WeatherManagerWithLocation {
  
  static let shared = WeatherManagerWithLocation()
  private let apiKey = "1c2ba745810db56a9f945361a2520a0a"
  
  func getCurrentWeatherData(lat: Double, lon: Double, locale: String, completion: @escaping(Result<CurrentWeather,WeatherError>) -> Void) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&lang=\(locale)&units=metric&appid=\(apiKey)") else {
      completion(.failure(.serverSideError))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(.failure(.serverSideError))
        return
      }
      
      do {
        let weatherData = try JSONDecoder().decode(CurrentWeather.self, from: data)
        DispatchQueue.main.async {
          completion(.success(weatherData))
        }
      }catch {
        completion(.failure(.decodingError))
      }
    }.resume()
  }
  
  func getDailyWeatherData(lat: Double, lon: Double, locale: String, completion: @escaping(Result<DailyWeather,WeatherError>) -> Void) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&units=metric&appid=\(apiKey)") else {
      completion(.failure(.serverSideError))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(.failure(.serverSideError))
        return
      }
      
      do {
        let weatherData = try JSONDecoder().decode(DailyWeather.self, from: data)
        DispatchQueue.main.async {
          completion(.success(weatherData))
        }
      }catch {
        completion(.failure(.decodingError))
      }
    }.resume()
  }
}
