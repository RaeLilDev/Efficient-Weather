//
//  ChooseLocationViewModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

class ChooseLocationViewModel: BaseViewModel {
    
    var newPlace = BehaviorRelay<PlaceVO?>(value: nil)
    
    private var placeModel: PlaceModel!
    private var selectedPlace: PlaceVO?
    
    private var selectedLat: Double?
    private var selectedLon: Double?
    
    init(placeModel: PlaceModel) {
        self.placeModel = placeModel
    }
    
    func fetchPlace() {
        placeModel.getPlace(lat: selectedLat ?? 0.0, lon: selectedLon ?? 0.0)
            .subscribe(onNext: {[weak self] data in
                guard let self = self else { return }
                if let result = data.first {
                    Preference.savePlaceInfo(result)
                    self.newPlace.accept(result)
                }
            }, onError: {[weak self] error in
                guard let self = self else { return }
                debugPrint("Handle error \(error)")
            }).disposed(by: disposeBag)
    }
    
    func updateLocation(lat: Double, lon: Double) {
        selectedLat = lat
        selectedLon = lon
    }
    
    func noPlaceExists() -> Bool {
        return selectedPlace?.city == nil
    }
}
