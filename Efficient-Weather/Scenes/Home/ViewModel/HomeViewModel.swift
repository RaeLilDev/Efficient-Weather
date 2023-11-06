//
//  HomeViewModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

enum HomeSectionData {
    case currentWeather(weather: WeatherVO)
    case forecastData(forecastList: [(String, [WeatherForecastVO])])
}

class HomeViewModel: BaseViewModel {
    
    var homeItems = BehaviorRelay<[HomeSectionData]>(value: [])

    private var forecastList = BehaviorRelay<[(String, [WeatherForecastVO])]>(value: [])
    private var currentWeather = BehaviorRelay<WeatherVO?>(value: nil)
    
    let weatherModel: WeatherModel!
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
    //MARK: - Init Observers
    func initObservers() {
        Observable.combineLatest(currentWeather, forecastList)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe{ [weak self] currentWeather, forecastList in
                guard let self = self else { return }
                
                var items: [HomeSectionData] = []
                
                if let weather = currentWeather {
                    items.append(.currentWeather(weather: weather))
                }
                
                if forecastList.count > 0 {
                    items.append(.forecastData(forecastList: forecastList))
                }
                
                self.homeItems.accept(items)
                
                stopLoading()
                
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Fetch Data
    func fetchAllData() {
        
        startLoading()
        
        fetchCurrentWeather(lat: 16.8050152422854, lon: 96.13827618458163)
        
        fetchWeatherForecast(lat: 16.8050152422854, lon: 96.13827618458163)
        
    }
    
    private func fetchCurrentWeather(lat: Double, lon: Double) {
        let place = getPlace()
        weatherModel.getCurrentWeather(lat: place?.lat ?? 0.0, lon: place?.lon ?? 0.0, city: place?.city ?? "")
            .skip(while: { $0.id == nil })
            .subscribe(onNext: {[weak self] response in
                guard let self = self else {return}
                self.currentWeather.accept(response)
        }, onError: {[weak self] error in
            guard let self = self else { return }
            self.handleError(error: error)
            self.stopLoading()
        }).disposed(by: disposeBag)
    }
    
    private func fetchWeatherForecast(lat: Double, lon: Double) {
        let place = getPlace()
        weatherModel.getWeatherForecast(lat: place?.lat ?? 0.0, lon: place?.lon ?? 0.0, city: place?.city ?? "")
            .subscribe(onNext: {[weak self] response in
                guard let self = self else { return }
                let mappedForecastList = self.mapForecastList(response)
                self.forecastList.accept(mappedForecastList)
            }, onError: {[weak self] error in
                guard let self = self else { return }
                self.handleError(error: error)
                self.stopLoading()
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Data Mapping logic
    private func mapForecastList(_ forecasts: [WeatherForecastVO]) -> [(String, [WeatherForecastVO])] {
        // Step 1: Extract unique date strings from notis
        let dateStrings: [String] = forecasts.compactMap { $0.forecastDate }.uniques

        // Step 2: Group forecasts by date
        let groupedForecasts: [(Date, [WeatherForecastVO])] = dateStrings.compactMap { dateString in
            let date = dateString.toDate(format: .type3) ?? Date()
            let forecastsByDate = forecasts.filter { $0.forecastDate == dateString }
            return (date, forecastsByDate)
        }
        
        // Step 3: Sort grouped forecasts by date
        let sortedGroupedForecasts = groupedForecasts.sorted { $0.0 < $1.0 }
        
        // Step 4: Format and add "Today" if applicable
        let output: [(String, [WeatherForecastVO])] = sortedGroupedForecasts.map { date, forecastsForDate in
            let isToday = date.toString(format: .type3) == Date().toString(format: .type3)
            let title: String = isToday ? "Today" : date.toString(format: .type7) ?? ""
            return (title, forecastsForDate)
        }
        return output
    }
    
    
    //MARK: - Get Methods
    func getPlace() -> PlaceVO? {
        return Preference.getPlaceInfo()
    }
    
    func getTemp() -> String {
        return "\(Int(currentWeather.value?.temp ?? 0.0))\u{00B0}"
    }
    
    func getDesc() -> String {
        return (currentWeather.value?.desc ?? "").capitalized
    }
    
    func getMinTemp() -> String {
        return "L:\(Int(currentWeather.value?.minTemp ?? 0.0))\u{00B0}"
    }
    
    func getMaxTemp() -> String {
        return "H:\(Int(currentWeather.value?.maxTemp ?? 0.0))\u{00B0}"
    }
    
    func getFeelsLikeTemp() -> String {
        return "\(Int(currentWeather.value?.feelsLikeTemp ?? 0.0))\u{00B0}"
    }
    
    func getHumidity() -> String {
        return "\(Int(currentWeather.value?.humidity ?? 0.0))%"
    }
    
    func getVisibility() -> String {
        let visibility = Double(currentWeather.value?.visibility ?? 0) * 0.000621371
        return "\(visibility.formatDecimal(place: 1)) mi"
    }
    
    func getWindSpeed() -> String {
        let speed = (currentWeather.value?.windSpeed ?? 0.0) * 2.23694
        return "\(speed.formatDecimal(place: 1)) mph"
    }
    
    func getCity() -> String {
        return currentWeather.value?.city ?? ""
    }
    
    func getIcon() -> String {
        return currentWeather.value?.icon ?? ""
    }
    
    func getForecastCount() -> Int {
        return forecastList.value.count
    }
    
    func getForecast(by index: Int) -> WeatherForecastVO? {
        return forecastList.value[index].1.first
    }
    
    func getDay(by index: Int) -> String {
        return forecastList.value[index].0
    }
    
    func getforecastList(by index: Int) -> [WeatherForecastVO] {
        return forecastList.value[index].1
    }
}
