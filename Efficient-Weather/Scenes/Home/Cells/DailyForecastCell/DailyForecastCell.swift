//
//  DailyForecastCell.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import UIKit

class DailyForecastCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblTempRange: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(with day: String, data: WeatherForecastVO?) {
        lblDay.text = day
        ivIcon.setWebImage(with: data?.icon ?? "")
        lblTempRange.text = "L:\(Int(data?.minTemp ?? 0.0))\u{00B0} - H:\(Int(data?.maxTemp ?? 0.0))\u{00B0}"
    }
    
}
