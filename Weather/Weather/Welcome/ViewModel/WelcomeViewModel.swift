//
//  WelcomeViewModel.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation
import CoreLocation
import Network

class WelcomeViewModel: NSObject {
  var weather = WeatherInterface()
  private let locationManager = CLLocationManager()
  private let monitorNetwork = NWPathMonitor()
  
  var showError: (() -> ())?
  
  func getWeatherData(completion: @escaping () -> ()) {
    self.weather.getWeather {
      completion()
    }
  }
  
  func getLocation() {
    self.getActualLocation()
  }
  
  private func checkNetworkStatus(){
    monitorNetwork.pathUpdateHandler = { path in
           if path.status == .satisfied {
               self.getActualLocation()
               if self.locationManager.authorizationStatus == .denied {
                 print("Denied")
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

extension WelcomeViewModel: CLLocationManagerDelegate {
  
  private func getActualLocation() {
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
        print("Denied")
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
  }
  
}
