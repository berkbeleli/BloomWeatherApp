//
//  WeatherViewController.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class WeatherViewController: UIViewController {
  @IBOutlet private weak var updateScrollView: UIScrollView!
  @IBOutlet private weak var shadowContainerView: UIView!
  @IBOutlet private weak var actualWeatherContainerView: UIView!
  @IBOutlet private weak var currentTemperatueLbl: UILabel!
  @IBOutlet private weak var feelingLbl: UILabel!
  @IBOutlet private weak var currentFeelingLbl: UILabel!
  @IBOutlet private weak var maxTemperatureLbl: UILabel!
  @IBOutlet private weak var currentMaxTemperatureLbl: UILabel!
  @IBOutlet private weak var currentHumidityLbl: UILabel!
  @IBOutlet private weak var humidityLbl: UILabel!
  @IBOutlet private weak var currentWeatherImage: UIImageView!
  @IBOutlet private weak var minTemperatureLbl: UILabel!
  @IBOutlet private weak var currentMinTemperatureLbl: UILabel!
  @IBOutlet private weak var pressureLbl: UILabel!
  @IBOutlet private weak var currentPressureLbl: UILabel!
  @IBOutlet private weak var currrentDescription: UILabel!
  @IBOutlet private weak var windSpeedLbl: UILabel!
  @IBOutlet private weak var currentWindSpeedLbl: UILabel!
  @IBOutlet private weak var currentTimeLbl: UILabel!
  @IBOutlet private weak var dailyCollectionView: UICollectionView!
  @IBOutlet private weak var hourlyCollectionView: UICollectionView!
  @IBOutlet private weak var backgroundImageView: UIImageView!
  
  private let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
