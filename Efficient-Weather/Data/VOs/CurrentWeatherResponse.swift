//
//  CurrentWeatherResponse.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

// MARK: - CurrentWeatherResponse
struct CurrentWeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
    
    func toWeatherVO(with city: String) -> WeatherVO {
        let object = WeatherVO()
        object.id = "\(Date.currentDate())\(city)"
        object.city = city
        object.main = self.weather?.first?.main ?? ""
        object.desc = self.weather?.first?.description ?? ""
        object.icon = self.weather?.first?.icon ?? ""
        object.temp = self.main?.temp ?? 0.0
        object.minTemp = self.main?.tempMin ?? 0.0
        object.maxTemp = self.main?.tempMax ?? 0.0
        object.feelsLikeTemp = self.main?.feelsLike ?? 0.0
        object.humidity = self.main?.feelsLike ?? 0.0
        object.visibility = self.visibility ?? 0
        object.windSpeed = self.wind?.speed ?? 0.0
        object.updatedAt = Date()
        return object
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double?
    let the2H: Double?
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the2H = "2h"
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
    let pod: String?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
