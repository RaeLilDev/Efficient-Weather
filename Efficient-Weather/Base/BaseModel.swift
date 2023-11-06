//
//  BaseModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import Alamofire
import RxSwift


class BaseModel {
    
    let service = ApiService.shared
    let disposeBag = DisposeBag()
    
    private var requests: [Request] = []
    
    func cancel() {
        requests.forEach { $0.cancel() }
    }
    
    deinit {
        print("Deinit: - " + String(describing: self))
    }
}
