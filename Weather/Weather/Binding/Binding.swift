//
//  Binding.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import Foundation

class Binding<T> {
  typealias Listener = (T) -> Void
  private var listerner: Listener?
  
  var value: T {
    didSet {
      listerner?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bin(_ listener: Listener?) {
    self.listerner = listener
    listener?(value)
  }
}
