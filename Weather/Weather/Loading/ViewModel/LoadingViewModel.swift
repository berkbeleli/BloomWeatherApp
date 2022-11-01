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
  var hideLoading: (() -> ())?
  var loadWelcomeVC: (() -> ())?
  
  func startApp() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.hideLoading?()
      self.loadWelcomeVC?()
    }
  }
}
