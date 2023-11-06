//
//  AppCoordinator.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation
import UIKit

class AppCoordinator {
    
    static let shared = AppCoordinator()
    
    private init() { }
    
    func coordinate(window: UIWindow?) {
        let placeSelected = Preference.getPlaceInfo()?.city != nil
        if placeSelected {
            let vc = HomeVC()
            vc.viewModel = HomeViewModel(weatherModel: WeatherModelImpl.shared)
            window?.rootViewController = UINavigationController(rootViewController: vc)
        } else {
            let vc = ChooseLocationVC()
            vc.viewModel = ChooseLocationViewModel(placeModel: PlaceModelImpl.shared)
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        window?.makeKeyAndVisible()
    }
    
    func restart() {
        let vc = HomeVC()
        vc.viewModel = HomeViewModel(weatherModel: WeatherModelImpl.shared)
        UIWindow.switchRootView(vc)
    }
    
    
}
