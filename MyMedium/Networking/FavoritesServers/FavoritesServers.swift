//
//  FavoritesServers.swift
//  MyMedium
//
//  Created by neosoft on 19/01/23.
//

import Foundation
import Alamofire

class FavoritesServices {
    
    func bookMarkArticle (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<FavArticleRes,NetworkError>) -> Void){
            return RestAPIClient.request(type: FavArticleRes.self,
                                         endPoint: FavoritesApiEndpoint().createEndPoint(endPoint: .addBookmark) + endpoint,
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func removeBookMarkArticle (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<FavArticleRes,NetworkError>) -> Void){
            return RestAPIClient.request(type: FavArticleRes.self,
                                         endPoint: FavoritesApiEndpoint().createEndPoint(endPoint: .addBookmark) + endpoint,
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
