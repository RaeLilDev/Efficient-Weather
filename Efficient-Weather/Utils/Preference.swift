//
//  Preference.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/5/23.
//

import Foundation

enum PreferenceKeys: String {
    case placeInfo
}


class Preference {
    
    // UserInfo
    static func savePlaceInfo(_ placeInfo: PlaceVO) {
        do {
            try UserDefaults.standard.setObject(placeInfo, forKey: PreferenceKeys.placeInfo.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getPlaceInfo() -> PlaceVO? {
        do {
            return try UserDefaults.standard.getObject(forKey: PreferenceKeys.placeInfo.rawValue, castTo: PlaceVO.self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
