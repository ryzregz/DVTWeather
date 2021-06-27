//
//  FavouriteCell.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/27/21.
//

import Foundation
import UIKit

class FavouriteCell: UITableViewCell {
    @IBOutlet weak var nameLabel : UILabel!

    func configureCellWithItem(location: Location) {
        nameLabel.text  = location.name
    }

}
