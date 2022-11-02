//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet private(set) weak var hourlyImageView: UIImageView!
  @IBOutlet private(set) weak var hourlyTmpLbl: UILabel!
  @IBOutlet private(set) weak var hourlyTimeLbl: UILabel!
  
  func setupCell(hourly: Hourly, index: Int) {
    hourlyTmpLbl.textColor = .white
    hourlyTimeLbl.textColor = .white
    hourlyImageView.contentMode = .scaleAspectFit
    hourlyImageView.image = UIImage(named: "\(hourly.weather.first!.icon)-i.png")
    hourlyTmpLbl.text = "Min:\(hourly.temp.doubleToString())°"
  }
}
