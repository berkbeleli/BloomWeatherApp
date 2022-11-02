//
//  String+Extension.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import Foundation

extension String {
  
  var localize: String {
      return NSLocalizedString(self, comment: "")
  }
  
  func capitalizingFirstLetter() -> String {
      return prefix(1).capitalized + dropFirst()
  }

  mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
  }
  
}
