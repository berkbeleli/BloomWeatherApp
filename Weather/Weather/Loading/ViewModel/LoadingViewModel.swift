//
//  LoadingViewModel.swift
//  Weather
//
//  Created by Berk Beleli on 2022-10-31.
//

import Foundation
import CoreLocation

class LoadingViewModel: NSObject {
  
  var showError: (() -> ())?
  
  private let locationManager = CLLocationManager()
  
  
  
  private func getWeatherData() {
    
  }
  
  
}

extension LoadingViewModel: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let manager = CLLocationManager()
    if CLLocationManager.locationServicesEnabled() {
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
    
  }
  
}
