//
//  WeatherModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import RxSwift

protocol WeatherModel {
    
    func getCurrentWeather(lat: Double, lon: Double, city: String) -> Observable<WeatherVO>
    
    func getWeatherForecast(lat: Double, lon: Double, city: String) -> RxSwift.Observable<[WeatherForecastVO]>
    
}

class WeatherModelImpl: BaseModel, WeatherModel {
    
    
    static let shared = WeatherModelImpl()
    
    private let weatherRepository = WeatherRepositoryImpl.shared
    
    private override init() {}
    
    func getCurrentWeather(lat: Double, lon: Double, city: String) -> RxSwift.Observable<WeatherVO> {
        let weatherId = "\(Date.currentDate())\(city)"
        
        let networkDataObservable = service.request(endpoint: .currentWeather(lat, lon), response: CurrentWeatherResponse.self)
            .map { self.weatherRepository.saveCurrentWeather(data: $0.toWeatherVO(with: city)) }
                .flatMap { _ in Observable<WeatherVO>.empty() }
                .catch { error in
                    return Observable.error(error)
                }
        return Observable.merge(weatherRepository.getCurrentWeather(id: weatherId) , networkDataObservable)
    }
    
    func getWeatherForecast(lat: Double, lon: Double, city: String) -> RxSwift.Observable<[WeatherForecastVO]> {
        
        let networkDataObservable = service.request(endpoint: .forecastWeather(lat, lon), response: ForecastWeatherResponse.self)
            .map { response in
                let remoteForecastList = response.list.map { $0.map { $0.toWeatherForecastVO(with: city) } } ?? []
                self.weatherRepository.saveForecastList(data: remoteForecastList)
            }
                .flatMap { _ in Observable<[WeatherForecastVO]>.empty() }
                .catch { error in
                    return Observable.error(error)
                }
        return Observable.merge(weatherRepository.getForecastList(date: Date.currentDate(), city: city) , networkDataObservable)
    }
    
}
