//
//  UIImageView++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setWebImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        let options: KingfisherOptionsInfo = [
            .transition(ImageTransition.fade(0.2)),
            .forceTransition,
            .cacheOriginalImage
        ]
        kf.setImage(with: URL(string: "http://openweathermap.org/img/w/\(urlString).png"), placeholder: nil, options: options, completionHandler: nil)
    }
}
