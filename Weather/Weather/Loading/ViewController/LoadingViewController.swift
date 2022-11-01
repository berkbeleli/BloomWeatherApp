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
    viewModel.startApp()
     self.animationView?.play()
    viewModel.loadWelcomeVC = {
      DispatchQueue.main.async {
        self.animationView?.stop()
      }
      guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.welcomeView) as? WelcomeViewController else { return }
      self.navigationController?.pushViewController(vc, animated: false)
    }
  }
}
