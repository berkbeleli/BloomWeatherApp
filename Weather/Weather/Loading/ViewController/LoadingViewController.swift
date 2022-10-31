//
//  LoadingViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-10-31.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
  
  private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      animationView = .init(name: "loader")
      animationView?.frame = view.bounds
      animationView?.contentMode = .scaleAspectFit
      animationView?.loopMode = .loop
      animationView?.animationSpeed = 2
      view.addSubview(animationView!)
      startApp()
    }
  
  private func startApp() {
    DispatchQueue.main.async {
      self.animationView?.play()
    }
  }
    


}
