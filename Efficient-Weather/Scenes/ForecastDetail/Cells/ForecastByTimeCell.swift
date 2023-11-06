//
//  ForecastByTimeCell.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/6/23.
//

import UIKit

class ForecastByTimeCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblMinMaxTemp: UILabel!
    
    var data: WeatherForecastVO? {
        didSet {
            if let data = data {
                lblTime.text = data.forecastTime
                lblDesc.text = (data.desc ?? "").capitalized
                ivIcon.setWebImage(with: data.icon ?? "")
                lblTemp.text = "\(Int(data.temp ?? 0.0))\u{00B0}"
                lblMinMaxTemp.text = "L:\(Int(data.minTemp ?? 0.0))\u{00B0} - H:\(Int(data.maxTemp ?? 0.0))\u{00B0}"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
