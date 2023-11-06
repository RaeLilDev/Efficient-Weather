//
//  WeatherForecastResponse.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

// MARK: - WeatherForecastResponse
struct ForecastWeatherResponse: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}


// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
    
    func toWeatherForecastVO(with city: String) -> WeatherForecastVO {
        let object = WeatherForecastVO()
        object.id = "\((self.dtTxt ?? "").utcToLocalDateStr(originFormat: .type1, resultFormat: .type1) ?? "")\(city)"
        object.city = city
        object.main = self.weather?.first?.main ?? ""
        object.desc = self.weather?.first?.description ?? ""
        object.icon = self.weather?.first?.icon ?? ""
        object.temp = self.main?.temp ?? 0.0
        object.minTemp = self.main?.tempMin ?? 0.0
        object.maxTemp = self.main?.tempMax ?? 0.0
        object.forecastDate = (self.dtTxt ?? "").utcToLocalDateStr(originFormat: .type1, resultFormat: .type3)
        object.forecastDay = (self.dtTxt ?? "").utcToLocalDateStr(originFormat: .type1, resultFormat: .type7)
        object.forecastTime = (self.dtTxt ?? "").utcToLocalDateStr(originFormat: .type1, resultFormat: .type5)
        object.forecastDateTime = (self.dtTxt ?? "").utcToLocalDateStr(originFormat: .type1, resultFormat: .type1)?.toDate(format: .type1)
        object.updatedDate = Date.currentDate()
        return object
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}


