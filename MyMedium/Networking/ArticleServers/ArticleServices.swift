//
//  ArticleServices.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import Foundation
import Alamofire

class ArticleServices {
    
    func getTrandingArticle (
        parameters: Parameters?,
        completion: @escaping(Result<TrandingArticles,NetworkError>) -> Void){
            return RestAPIClient.request(type: TrandingArticles.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .getTranding),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getFeedArticle (
        parameters: Parameters?,
        completion: @escaping(Result<FeedArticle,NetworkError>) -> Void){
            return RestAPIClient.request(type: FeedArticle.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .feed),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
