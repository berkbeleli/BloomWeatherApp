//
//  City.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

class City: Codable {
  var name: String?
  var country: String?
  var coord: Coordinats?
}

class Coordinats: Codable {
  var lat: Double?
  var lon: Double?
}
