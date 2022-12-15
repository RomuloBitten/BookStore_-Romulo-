//
//  BookModel.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 14/12/22.
//

import Foundation
import SwiftyJSON

class BookModel {
    var id: String = ""
    var title: String = ""
    var authors: [String] = []
    var thumbnailLink: String = ""
    var buyLink: String?
    var isForSale: Bool = false
    
    internal init(id: String = "", title: String = "", authors: [String] = [], thumbnailLink: String = "", buyLink: String? = nil, isForSale: Bool = false) {
        self.id = id
        self.title = title
        self.authors = authors
        self.thumbnailLink = thumbnailLink
        self.buyLink = buyLink
        self.isForSale = isForSale
    }
    
    static func parseBookList(withJson json: JSON) -> [BookModel] {
        var newBookList: [BookModel] = []
        
        let jsonBookList = json["items"].arrayValue
        
        for jsonBook in jsonBookList {
            newBookList.append(BookModel(
                id: jsonBook["id"].stringValue,
                title: jsonBook["volumeInfo"]["title"].stringValue,
                authors: jsonBook["volumeInfo"]["authors"].arrayObject as? [String] ?? [],
                thumbnailLink: jsonBook["imageLinks"]["smallThumbnail"].stringValue,
                buyLink: jsonBook["saleInfo"]["buyLink"].string,
                isForSale: jsonBook["saleInfo"]["saleability"].stringValue == "FOR_SALE"
            )
            )
        }
        
        return newBookList
    }
}
