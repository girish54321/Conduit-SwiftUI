//
//  ArticleApiEndpoint.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import Foundation
class ArticleApiEndpoint {
    
    enum ArticleApiType {
        case getTranding
        case feed
        case uploadArticle
    }
    
    func createEndPoint(endPoint: ArticleApiType) -> String {
        switch endPoint {
        case .getTranding:
            return createApi(endPoint: "articles")
        case .feed:
            return createApi(endPoint: "articles/feed")
        case .uploadArticle:
            return createApi(endPoint: "articles")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
