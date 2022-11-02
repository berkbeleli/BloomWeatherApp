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
  
}
