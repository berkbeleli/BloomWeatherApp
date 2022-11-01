//
//  WeatherInterface.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

class WeatherInterface {
  private var lang = Locale.current.language.languageCode?.identifier
  var lat: Double? = 48.864716
  var lon: Double? = 2.349014
  var currentWeather: CurrentWeather?
  var dailyWeather: DailyWeather?
  
  private let group = DispatchGroup()
  
  func getWeather(completion: @escaping () -> ()) {
    
    group.enter()
    WeatherManager.shared.getCurrentWeatherData(lat: lat!, lon: lon!, locale: lang!) { [weak self] result in
      
      switch result {
      case .success(let weather):
        self?.currentWeather = weather
      case .failure(let error):
        print(error.localizedDescription)
      }
      self?.group.leave()
    }
    
    group.enter()
    
    WeatherManager.shared.getDailyWeatherData(lat: lat!, lon: lon!, locale: lang!) { [weak self] result in
      
      switch result {
      case .success(let weather):
        self?.dailyWeather = weather
      case .failure(let error):
        print(error.localizedDescription)
      }
      self?.group.leave()
    }
    
    group.notify(queue: .main) {
        completion()
    }
  }
}
