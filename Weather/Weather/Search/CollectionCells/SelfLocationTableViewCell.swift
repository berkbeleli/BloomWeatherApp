//
//  SelfLocationTableViewCell.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class SelfLocationTableViewCell: UITableViewCell {

  @IBOutlet weak var locationIconimg: UIImageView!
  @IBOutlet weak var locationLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  func setupCell() {
    locationLbl.text = "Use current location".localize
  }

}
