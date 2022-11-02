//
//  SearchViewModel.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import Foundation
import CoreLocation

protocol SearchViewModelDelegate: AnyObject {
    func setLocation(_ lat: Double, _ lon: Double)
}

class SearchViewModel: NSObject {
  
  var reloadTableView: (()->())?
  weak var delegate: SearchViewModelDelegate?
  private let locationManager = CLLocationManager()
  private var filteredCities = [City]()
  private var lat: Double?
  private var lon: Double?
  private var cellViewModel = [SearchCellViewModel]() {
      didSet {
          self.reloadTableView?()
      }
  }
  
  var numberOfCell: Int {
      if filteredCities.count > 20 {
          return 20
      } else if filteredCities.count > 0 {
          return filteredCities.count
      } else {
          return 1
      }
  }
  
  func getCity() {
      loadCities()
      actualLocation()
  }
  
  func loadCities() {
    CityInterface.shared.getCity()
  }
  
  func didSelectRow(at indexPath: IndexPath) {
      if filteredCities.isEmpty {
          if locationManager.authorizationStatus != .denied {
              self.delegate?.setLocation(self.lat!, self.lon!)
          }
      } else {
        self.delegate?.setLocation(filteredCities[indexPath.row].coord!.lat!, filteredCities[indexPath.row].coord!.lon!)
      }
  }
  
  func searchCity(text: String) {
      guard let cities = CityInterface.shared.cities else { return }
      
      filteredCities = cities.filter({ (city: City) in
        if text.count > 2 && city.name!.lowercased().contains(text.lowercased()) {
              return true
          }
          return false
      })
    filteredCities.sort(by: {$0.name!.count < $1.name!.count})
      createCell()
  }
  
  func getCellViewModel(at indexPath: IndexPath) -> SearchCellViewModel {
      return cellViewModel[indexPath.row]
  }
  
  func filteredCityIsEmpty() -> Bool {
      filteredCities.isEmpty
  }
  
  private func createCell(){
      var viewModelCell = [SearchCellViewModel]()
      for city in filteredCities {
        viewModelCell.append(SearchCellViewModel(city: city.name!, country: city.country!))
      }
      cellViewModel = viewModelCell
  }
  
}

struct SearchCellViewModel {
    var city: String
    var country: String
}
extension SearchViewModel: CLLocationManagerDelegate {
    private func actualLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        lat = location.latitude
        lon = location.longitude
        locationManager.stopUpdatingLocation()
    }
}
