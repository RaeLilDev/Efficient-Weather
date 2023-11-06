//
//  Endpoint.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import Alamofire



enum Endpoint {
    
    case currentWeather(Double, Double)
    
    case forecastWeather(Double, Double)
    
    case cityName(Double, Double)
    
    var headers: HTTPHeaders? {
        [
            "Accept": "application/json",
        ]
    }
    
    var attribute: EndpointAttribute {
        switch self {
        case .currentWeather(let lat, let lon):
            return .init(path: "data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(ApiConstants.apiKey)", method: .get, encoding: .json)
            
        case .forecastWeather(let lat, let lon):
            return .init(path: "data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(ApiConstants.apiKey)", method: .get, encoding: .json)
            
        case .cityName(let lat, let lon):
            return .init(path: "geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(ApiConstants.apiKey)", method: .get, encoding: .json)
        }
    }
    
}
