//
//  DailyCollectionViewCell.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
  @IBOutlet private(set) weak var dailyImageView: UIImageView!
  @IBOutlet private(set) weak var dailyDateLbl: UILabel!
  @IBOutlet private(set) weak var dailyMaxTmpLbl: UILabel!
  @IBOutlet private(set) weak var dailyMinTmpLbl: UILabel!
  
  func setupCell(daily: Daily, index: Int) {
    dailyDateLbl.textColor = .white
    dailyMaxTmpLbl.textColor = .white
    dailyMinTmpLbl.textColor = .white
    dailyImageView.contentMode = .scaleAspectFit
    dailyImageView.image = UIImage(named: "\(daily.weather?.first!.icon ?? "0")-i.png")
    dailyMinTmpLbl.text = "Min:\(daily.temp?.min?.doubleToString() ?? "0")°"
    dailyMaxTmpLbl.text = "Max:\(daily.temp?.max?.doubleToString() ?? "0")°"
  }
  
}
