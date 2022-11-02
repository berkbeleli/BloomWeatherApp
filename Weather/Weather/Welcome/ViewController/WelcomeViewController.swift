//
//  WelcomeViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import UIKit
import AVKit

class WelcomeViewController: UIViewController {

  @IBOutlet private weak var IconImage: UIImageView!
  @IBOutlet private weak var greetingLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var continueButton: UIButton!
  @IBOutlet private weak var privacyLabel: UILabel!
  
  private var playerLooper:NSObject?
  
  private var viewModel = WelcomeViewModel()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    playBackgroundVideo()
    updateUI()
    setupVM()
  }
    
  func updateUI() {
    self.continueButton.addButtonRadius()
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.greetingLabel.text = "Welcome!".localize
    self.descriptionLabel.text = "The 'BloomWeather' app provides accurate forecast wherever you are. Therefore You should allow us to use your Location Services.".localize
    self.continueButton.setTitle("Next".localize, for: .normal)
    self.privacyLabel.text = "We use and share the precise location of your device based оn our Privacy Policy".localize
  }

  private func playBackgroundVideo() {
    guard let url = Bundle.main.url(forResource: "cloud", withExtension: "mp4") else { return }
   
    // Create the video player item
    let item = AVPlayerItem(url: url)
    // Assign an array of 1 item to AVQueuePlayer
    let videoPlayer = AVQueuePlayer(items: [item])
    // Loop the video
    playerLooper = AVPlayerLooper(player: videoPlayer, templateItem: item)
    // Create the layer
    let videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
    // Adjust the size and frame
    videoPlayerLayer.frame = view.bounds
    videoPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    self.view.layer.insertSublayer(videoPlayerLayer, at: 0)

    playerLooper = AVPlayerLooper(player: videoPlayer, templateItem: item)
    // Add it to the view and play it
    videoPlayer.play()
  }
  
  private func setupVM() {
    viewModel.getLocation()
  }

  @IBAction func continueButtonPressed(_ sender: UIButton) {
    guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.weatherView) as? WeatherViewController else { return }
  
    viewModel.getWeatherData {
      vc.modalPresentationStyle = .fullScreen
      vc.viewModel.weather = self.viewModel.weather
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}
