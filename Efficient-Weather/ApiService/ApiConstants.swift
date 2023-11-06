//
//  ApiConstants.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation


class ApiConstants {
    static var baseUrl: String {
        let base = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        return base
    }
    
    static var apiKey: String {
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
        return accessToken
    }
    
}
