//
//  CityInterace.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import Foundation
class CityInterface {
    
    var cities: [City]?
    
    static let shared = CityInterface()
    private init () {}
    
    func getCity() {
       let queue = DispatchQueue(label: "com.berkbeleli.cityResponse")
       queue.async {
          CityManager.shared.getCity { [weak self] newCity in
              self?.cities = newCity
          }
       }
    }
}
