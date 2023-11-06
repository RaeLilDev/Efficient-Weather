//
//  ForecastDetailViewModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

class ForecastDetailViewModel {
    
    private var day: String?
    private var forecastList: [WeatherForecastVO]?
    
    init(day: String, forecastList: [WeatherForecastVO]) {
        self.day = day
        self.forecastList = forecastList
    }
    
    func getDay() -> String {
        return day ?? ""
    }
    
    func getForecastCount() -> Int {
        return forecastList?.count ?? 0
    }
    
    func getForecast(by index: Int) -> WeatherForecastVO? {
        return forecastList?[index]
    }
    
}
