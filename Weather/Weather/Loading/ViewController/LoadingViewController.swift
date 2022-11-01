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
  
  private var viewModel = LoadingViewModel()

    override func viewDidLoad() {
      super.viewDidLoad()
      setupUI()
      connection()
    }
  
  private func setupUI() {
    animationView = .init(name: "loader")
    animationView?.frame = view.bounds
    animationView?.contentMode = .scaleAspectFit
    animationView?.loopMode = .loop
    animationView?.animationSpeed = 2
    view.addSubview(animationView!)
  }
  
  private func connection() {
    viewModel.showLoading = {
      DispatchQueue.main.async {
        self.animationView?.play()
      }
    }
    
    viewModel.hideLoading = {
      DispatchQueue.main.async {
        self.animationView?.stop()
      }
    }
    
    viewModel.checkIfFirstOpeningApp()
  }
    


}
