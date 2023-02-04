//
//  FavoritesApiEndPoint.swift
//  Conduit
//
//  Created by na on 19/01/23.
//

import Foundation
class FavoritesApiEndpoint {
    
    enum FavoritesApiType {
        case addBookmark
    }
    
    func createEndPoint(endPoint: FavoritesApiType) -> String {
        switch endPoint {
        case .addBookmark:
            return createApi(endPoint: "articles/")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
