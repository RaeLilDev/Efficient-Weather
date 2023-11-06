//
//  BaseViewModel.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    let loadingObservable = PublishRelay<Bool>()
    let errorObservable = PublishRelay<ApiError>()
    
    func handleError(error: Error) {
        errorObservable.accept(error as! ApiError)
    }
    
    func startLoading() {
        loadingObservable.accept(true)
    }
    
    func stopLoading() {
        loadingObservable.accept(false)
    }
}
