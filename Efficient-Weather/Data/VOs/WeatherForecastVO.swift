//
//  WeatherForcastVO.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import RealmSwift

class WeatherForecastVO: Object {
    
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
    var forecastDate: String?
    
    @Persisted
    var forecastDay: String?
    
    @Persisted
    var forecastTime: String?
    
    @Persisted
    var forecastDateTime: Date?
    
    @Persisted
    var updatedDate: String?
    
}
