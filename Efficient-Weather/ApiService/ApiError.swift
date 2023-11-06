//
//  ApiError.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation

enum ApiError: Error {
    
    case noConnection
    
    case sessionExpired
    
    case decodingError(Int)
    
    case serverError(String)
    
    case requestTimeOut
    
    case requestCancel
    
    
    var description: String {
        switch self {
        case .noConnection:
            return "No Connection."
        case .sessionExpired:
            return "Session Expired."
        case .decodingError(let code):
            return "StatusCode: \(code) - An error occurs in decoding."
        case .serverError(let code):
            return "StatusCode: \(code) - Something went wrong."
        case .requestTimeOut:
            return "You have an unstable network at the moment, please try again when network stabilizes."
        case .requestCancel:
            return "Request has been cancelled."
        }
    }

}
