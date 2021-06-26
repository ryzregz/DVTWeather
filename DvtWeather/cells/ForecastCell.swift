//
//  ForecastCell.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/20/21.
//

import UIKit

class ForecastCell: UITableViewCell {
    @IBOutlet weak var dayLabel : UILabel!
    @IBOutlet weak var temparatureLabel : UILabel!

    func configureCellWithItem(weather: Weather) {
        dayLabel.text  = weather.dt_txt!.getDate()?.dateConverter()
        temparatureLabel.text = "\(weather.main.temp.convertToTemparature())"
        
    }

}
