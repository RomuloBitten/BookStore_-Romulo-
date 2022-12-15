//
//  ErrorHelper.swift
//  BookStore_[Romulo]
//
//  Created by Romulo B. Mantovani on 13/12/22.
//

import Foundation

extension NSError {
    static var apiCallGenericError = NSError(domain: "APICall unacessible", code: 400, userInfo: nil)
}
