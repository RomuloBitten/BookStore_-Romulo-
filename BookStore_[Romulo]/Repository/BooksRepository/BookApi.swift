//
//  BookApi.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 14/12/22.
//

import Foundation
import RxSwift

enum BookAPIEndpoint {
    case getiOSBooks(maxResults: Int, startIndex: Int)
}

class BookAPICall: APICall {
    static let baseURL = "https://www.googleapis.com/books/"
    fileprivate static func bookEndpoint(_ endpoint: BookAPIEndpoint) -> APICall{
        switch endpoint {
        case .getiOSBooks(let maxResults, let startIndex):
            return APICall(path: "\(baseURL)v1/volumes?q=ios&maxResults=\(maxResults)&startIndex=\(startIndex)", method: .get)
        }
    }
}

class BookRepository {
    func rxGetIosBooks(maxResults: Int, startIndex: Int) -> Observable<[BookModel]>{
        let call = BookAPICall.bookEndpoint(.getiOSBooks(maxResults: maxResults, startIndex: startIndex))
        
        return call.request().map { (_, json) -> [BookModel] in
            BookModel.parseBookList(withJson: json)
        }
    }
}
