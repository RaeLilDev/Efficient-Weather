//
//  PlaceVO.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

struct PlaceVO: Codable {
    
    let lat: Double?
    let lon: Double?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case city = "name"
    }
}
