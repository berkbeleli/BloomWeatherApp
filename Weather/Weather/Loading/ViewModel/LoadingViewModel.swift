//
//  LoadingViewModel.swift
//  Weather
//
//  Created by Berk Beleli on 2022-10-31.
//

import Foundation
import CoreLocation
import Network

class LoadingViewModel: NSObject {
  
  var showLoading: (() -> ())?
  var hideLoading: (() -> ())?
  var showError: (() -> ())?
  var loadWeatherVC: (() -> ())?
  var loadWelcomeVC: (() -> ())?
  var weather = WeatherInterface()
  
  private let locationManager = CLLocationManager()
  private let monitorNetwork = NWPathMonitor()
  
  
  private func getWeatherData() {
    self.weather.getWeather {
      print("successs")
    }
  }
  
  func checkIfFirstOpeningApp() {
    showLoading?()
    if UserDefaults.standard.value(forKey: "firstOpen") == nil {
      loadWelcomeVC?()
      checkNetworkStatus()
    } else {
      checkNetworkStatus()
    }
    
  }
  
  private func checkNetworkStatus(){
    monitorNetwork.pathUpdateHandler = { path in
           if path.status == .satisfied {
               self.getActualLocation()
               if self.locationManager.authorizationStatus == .denied {
                   self.getWeatherData()
               }
           } else {
               DispatchQueue.main.async {
                   self.showError?()
               }
           }
       }
       let queue = DispatchQueue(label: "Monitor")
       monitorNetwork.start(queue: queue)
       
   }
  
}

extension LoadingViewModel: CLLocationManagerDelegate {
  
  func getActualLocation() {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if CLLocationManager.locationServicesEnabled() {
      let manager = CLLocationManager()
      switch manager.authorizationStatus {
      case .notDetermined, .restricted, .denied:
        getWeatherData()
      case .authorizedAlways, .authorizedWhenInUse:
        print("Accessed")
      default:
        break
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = manager.location?.coordinate else { return }
    weather.lat = location.latitude
    weather.lon = location.longitude
    locationManager.stopUpdatingLocation()
    getWeatherData()
  }
  
}
