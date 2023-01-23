//
//  CommentServers.swift
//  MyMedium
//
//  Created by Girish Parate on 23/01/23.
//

import Foundation
import Alamofire

class CommentsServices {
    
    func getComments (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<CommentListResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: CommentListResponse.self,
                                         endPoint: CommentsApiEndpoint().createEndPoint(endPoint: .getComments) + endpoint,
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
