//
//  CurrentWeatherVO.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import RealmSwift
import RxRealm

class WeatherVO: Object {
    
    @Persisted(primaryKey: true)
    var id: String?
    
    @Persisted
    var city: String?
    
    @Persisted
    var main: String?
    
    @Persisted
    var desc: String?
    
    @Persisted
    var icon: String?
    
    @Persisted
    var temp: Double?
    
    @Persisted
    var minTemp: Double?
    
    @Persisted
    var maxTemp: Double?
    
    @Persisted
    var feelsLikeTemp: Double?
    
    @Persisted
    var humidity: Double?
    
    @Persisted
    var visibility: Int?
    
    @Persisted
    var windSpeed: Double?
    
    @Persisted
    var updatedAt: Date?
    
}
