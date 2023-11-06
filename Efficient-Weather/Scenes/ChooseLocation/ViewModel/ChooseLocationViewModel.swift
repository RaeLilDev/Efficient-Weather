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
    
    init(placeModel: PlaceModel, selectedPlace: PlaceVO? = nil) {
        self.placeModel = placeModel
        self.selectedPlace = selectedPlace
    }
    
    func fetchPlace() {
        startLoading()
        placeModel.getPlace(lat: selectedLat ?? 0.0, lon: selectedLon ?? 0.0)
            .subscribe(onNext: {[weak self] data in
                guard let self = self else { return }
                if let result = data.first {
                    Preference.savePlaceInfo(result)
                    self.newPlace.accept(result)
                    self.stopLoading()
                }
            }, onError: {[weak self] error in
                guard let self = self else { return }
                self.stopLoading()
                self.handleError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func updateLocation(lat: Double, lon: Double) {
        selectedLat = lat
        selectedLon = lon
    }
    
    func getSelectedPlaceLat() -> Double {
        return selectedPlace?.lat ?? 0.0
    }
    
    func getSelectedPlaceLon() -> Double {
        return selectedPlace?.lon ?? 0.0
    }
    
    func noPlaceExists() -> Bool {
        return selectedPlace?.city == nil
    }
}
