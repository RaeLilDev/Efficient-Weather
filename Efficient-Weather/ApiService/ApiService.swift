//
//  ApiService.swift
//  Efficient-Weather
//
//  Created by Ye linn htet on 11/4/23.
//

import Foundation
import Alamofire
import RxSwift

enum RequestResult<T: Decodable>{
    case success(T)
    case failure(ApiError)
}

class ApiService {
    static let shared = ApiService()
    
    private var session: Session
    
    private init() {
        let configuaration = URLSessionConfiguration.default
        configuaration.timeoutIntervalForRequest = 60
        configuaration.requestCachePolicy = .useProtocolCachePolicy
        
        session = Session(configuration: configuaration, requestQueue: .background)
    }
    
    func request<T: Decodable> (endpoint: Endpoint, response: T.Type) -> Observable<T> {
        return Observable.create { observer in
            let dataRequest = self.createDataRequest(endpoint: endpoint)
            self.handleDataResponse(dataRequest: dataRequest, observer: observer)
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
    
    private func createDataRequest(endpoint: Endpoint) -> DataRequest {
        return session.request(
            endpoint.attribute.url,
            method: endpoint.attribute.method,
            encoding: endpoint.attribute.encoding,
            headers: endpoint.headers
        )
    }
    
    private func handleDataResponse<T: Decodable>(dataRequest: DataRequest, observer: AnyObserver<T>) {
        dataRequest.responseData { responseData in
            let statusCode = responseData.response?.statusCode ?? 0
            switch responseData.result {
            case .success(let data):
                self.handleSuccessResponse(data: data, statusCode: statusCode, observer: observer)
            case .failure(let error):
                self.handleFailureResponse(error: error, observer: observer)
            }
        }
    }
    
    private func handleSuccessResponse<T: Decodable>(data: Data, statusCode: Int, observer: AnyObserver<T>) {
        do {
            if 200...299 ~= statusCode {
                let resultData = try JSONDecoder().decode(T.self, from: data)
                observer.onNext(resultData)
                observer.onCompleted()
            } else {
                observer.onError(ApiError.serverError(String(statusCode)))
            }
        } catch {
            observer.onError(ApiError.decodingError(statusCode))
        }
    }
    
    private func handleFailureResponse<T: Decodable>(error: AFError, observer: AnyObserver<T>) {
        switch error {
        case .sessionTaskFailed(error: URLError.dataNotAllowed),
             .sessionTaskFailed(error: URLError.networkConnectionLost),
             .sessionTaskFailed(error: URLError.notConnectedToInternet):
            observer.onError(ApiError.noConnection)
        case .sessionTaskFailed(error: URLError.timedOut):
            observer.onError(ApiError.requestTimeOut)
        case .explicitlyCancelled:
            observer.onError(ApiError.requestCancel)
        default:
            observer.onError(ApiError.serverError(error.errorDescription ?? ""))
        }
    }
}
