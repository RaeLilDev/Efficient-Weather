//
//  Double++.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

extension Double {
    func formatDecimal(place: Int) -> String {
        return String.init(format: "%.\(place)f", self)
    }
}
