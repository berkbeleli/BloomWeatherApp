//
//  SearchCitiesTableViewCell.swift
//  Weather
//
//  Created by Berk Beleli on 2022-11-02.
//

import UIKit

class SearchCitiesTableViewCell: UITableViewCell {

  @IBOutlet weak var cityNameLbl: UILabel!
  @IBOutlet weak var countryNameLbl: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func setupCell(filteredCities: String) {
    cityNameLbl.text = ""
    countryNameLbl.text = ""
    self.backgroundColor = .clear
  }
 

}
