//
//  WelcomeViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-01.
//

import UIKit

class WelcomeViewController: UIViewController {

  @IBOutlet weak var IconImage: UIImageView!
  @IBOutlet weak var greetingLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var continueButton: UIButton!
  @IBOutlet weak var privacyLabel: UILabel!
  override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
    
  func updateUI() {
    self.continueButton.addButtonRadius()
    self.navigationItem.setHidesBackButton(true, animated: true)
    self.greetingLabel.text = "Welcome!".localize
  }


  @IBAction func continueButtonPressed(_ sender: UIButton) {
  }
  
}
