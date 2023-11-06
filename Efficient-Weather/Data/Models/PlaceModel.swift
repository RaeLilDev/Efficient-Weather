//
//  PlaceModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import RxSwift


protocol PlaceModel {
    
    func getPlace(lat: Double, lon: Double) -> Observable<[PlaceVO]>
    
}

class PlaceModelImpl: BaseModel, PlaceModel {
    
    static let shared = PlaceModelImpl()
    
    private override init() {}
    
    func getPlace(lat: Double, lon: Double) -> RxSwift.Observable<[PlaceVO]> {
        service.request(endpoint: .cityName(lat, lon), response: [PlaceVO].self)
    }
    
}
