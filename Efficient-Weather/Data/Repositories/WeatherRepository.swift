//
//  WeatherRepository.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol WeatherRepository {
    
    func saveCurrentWeather(data: WeatherVO)
    
    func saveForecastList(data: [WeatherForecastVO])
    
    func getCurrentWeather(id: String) -> Observable<WeatherVO>
    
    func getForecastList(date: String, city: String) -> Observable<[WeatherForecastVO]>
}

class WeatherRepositoryImpl: BaseRepository, WeatherRepository {
    
    static let shared: WeatherRepository = WeatherRepositoryImpl()
    
    private override init() { }
    
    func saveCurrentWeather(data: WeatherVO) {
        try! realmInstance.db.write {
            realmInstance.db.add(data, update: .modified)
        }
    }
    
    func saveForecastList(data: [WeatherForecastVO]) {
        try! realmInstance.db.write {
            realmInstance.db.add(data, update: .modified)
        }
    }
    
    func getCurrentWeather(id: String) -> Observable<WeatherVO> {
        let items = realmInstance.db.objects(WeatherVO.self).filter("id == %@", id)
        let resultsObservable = Observable.changeset(from: items)
        let mappedObservable = resultsObservable.map { changes in
            if let firstResult = items.first {
                return firstResult
            } else {
                return WeatherVO()
            }
        }
        return mappedObservable
    }
    
    func getForecastList(date: String, city: String) -> Observable<[WeatherForecastVO]> {
        let predicate = NSPredicate(format: "updatedDate == %@ AND city == %@", date, city)
        let items = realmInstance.db.objects(WeatherForecastVO.self).filter(predicate)
        return Observable.array(from: items)
    }
    
    
}
