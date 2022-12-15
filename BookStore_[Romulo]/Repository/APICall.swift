//
//  APICall.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 13/12/22.
//

import Foundation
import RxSwift
import SwiftyJSON

class APICall {
    let path: String
    let method: HTTPMethod
    var parameters: [String: Any]?
    var headers: [String: String]?
    
    init(path: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    func addParameters(_ customParams: [String: Any]) {
        if let count = self.parameters?.count, count > 0 {
            for key in customParams.keys {
                self.parameters![key] = customParams[key]
            }
        } else {
            self.parameters = customParams
        }
    }
    
    func addHeaders(_ customHeaders: [String: String]) {
        if let count = self.headers?.count, count > 0 {
            for key in customHeaders.keys {
                self.headers![key] = customHeaders[key]
            }
        } else {
            self.headers = customHeaders
        }
    }
    
    func request() -> Observable<(HTTPURLResponse, SwiftyJSON.JSON)> {
        return Observable.create { [weak self] observer in
            guard let self = self, let url = URL(string: self.path) else {
                observer.onError(NSError.apiCallGenericError)
                return Disposables.create()
            }
            var request = URLRequest(url: url)
            request.httpMethod = self.method.rawValue
            
            if let headers = self.headers {
                request.allHTTPHeaderFields = headers
            }
            if let parameters = self.parameters {
                let serializedJson = try? JSONSerialization.data(withJSONObject: parameters)
                request.setValue("\(String(describing: serializedJson?.count))", forHTTPHeaderField: "Content-Length")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = serializedJson
            }
            
            
            let task = URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse ?? HTTPURLResponse()
                    let json = JSON(httpResponse)
                    observer.onNext((httpResponse, json))
                    observer.onCompleted()
                }
            }
            task.resume()
            
            return Disposables.create()
        }
    }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
