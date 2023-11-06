//
//  Realm.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RealmSwift

class WeatherRealm: NSObject {
    
    static let shared = WeatherRealm()
    
    let db = try! Realm()
    
    override init() {
        
        super.init()
        
        print("Default Realm is at \(db.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
