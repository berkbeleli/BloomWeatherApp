//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class WeatherViewModel: NSObject {
  
  var navigationBarTitle = Binding<String?>(nil)
  var currentTemperature = Binding<String?>(nil)
  var currentFeeling = Binding<String?>(nil)
  var currentMaxTmp = Binding<String?>(nil)
  var currentMinTmp = Binding<String?>(nil)
  var currentHumidity = Binding<String?>(nil)
  var currentPressure = Binding<String?>(nil)
  var currentDescription = Binding<String?>(nil)
  var currentImageWeather = Binding<UIImage?>(nil)
  var currentWindSpeed = Binding<String?>(nil)
  var currentTime = Binding<String?>(nil)
  var backgroundImage = Binding<UIImage?>(nil)
  var currentWeatherObject = Binding<CurrentWeather?>(nil)
  var dailyWeather = Binding<DailyWeather?>(nil)
  
  var weather = WeatherInterface()
  var reloadCollectionViews: (() -> ())?
  
  var numberOfDailyCells: Int {
    return weather.dailyWeather?.daily?.count ?? 8
  }
  
  var numberOfHourlyCells: Int {
    return weather.dailyWeather?.hourly?.count ?? 24
  }
  
  func implementWeatherDatas() {
    guard let currentWeather = self.weather.currentWeather else { return }
    navigationBarTitle.value = currentWeather.name
    currentTemperature.value = "\(currentWeather.main?.temp?.doubleToString() ?? "0")°"
    currentFeeling.value = "\(currentWeather.main?.feelsLike?.doubleToString() ?? "0")°"
    currentMaxTmp.value = "\(currentWeather.main?.tempMax?.doubleToString() ?? "0")°"
    currentMinTmp.value = "\(currentWeather.main?.tempMin?.doubleToString() ?? "0")°"
    currentHumidity.value = "\(currentWeather.main?.humidity?.doubleToString() ?? "0")°"
    currentPressure.value = "\(currentWeather.main?.pressure?.doubleToString() ?? "0")°"
    currentDescription.value = currentWeather.weather?.first!.description?.capitalizingFirstLetter()
    currentWindSpeed.value = "\(currentWeather.wind?.speed ?? 0)м/с"
    currentTime.value = dateFormatter(date: currentWeather.dt, dateFormat: "HH:mm E")
    currentImageWeather.value = UIImage(named: "\(currentWeather.weather?.first!.icon ?? "0")-i.png")
    backgroundImage.value = UIImage(named: "\(currentWeather.weather?.first!.icon ?? "0")-b")
    reloadCollectionViews?()
  }
  
  func getWeatherData() {
    weather.getWeather {
      self.implementWeatherDatas()
    }
  }
  
  private func dateFormatter(date: TimeInterval, dateFormat: String) -> String {
    let dateString = Date(timeIntervalSince1970: date)
    let formater = DateFormatter()
    formater.timeZone = TimeZone(secondsFromGMT: weather.currentWeather?.timezone ?? 0)
    formater.dateFormat = dateFormat
    return formater.string(from: dateString)
  }
  
  func dailyCellConfigure(cell: DailyCollectionViewCell, indexPath: IndexPath) -> DailyCollectionViewCell {
    cell.setupCell(daily: weather.dailyWeather!.daily![indexPath.row], index: indexPath.row)
    cell.dailyDateLbl.text = dateFormatter(date: (weather.dailyWeather!.daily![indexPath.row].dt!), dateFormat: "E d MMM")
    return cell
  }
  
  func hourlyCellConfigure(cell: HourlyCollectionViewCell, indexPath: IndexPath) -> HourlyCollectionViewCell {
    cell.setupCell(hourly: weather.dailyWeather!.hourly![indexPath.row], index: indexPath.row)
    cell.hourlyTimeLbl.text = dateFormatter(date: (weather.dailyWeather!.hourly![indexPath.row].dt), dateFormat: "HH:mm")
    return cell
  }
  
  
}

//MARK: - Extensions
extension WeatherViewModel: SearchViewModelDelegate {
    func setLocation(_ lat: Double, _ lon: Double) {
        self.weather.lon = lon
        self.weather.lat = lat
        getWeatherData()
    }
}
