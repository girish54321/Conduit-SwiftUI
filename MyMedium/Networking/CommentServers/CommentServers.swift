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
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func addComment (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<CommentResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: CommentResponse.self,
//                                         endPoint: "https://api.realworld.io/api/articles/12-2-127899/comments",
                                         endPoint: CommentsApiEndpoint().createEndPoint(endPoint: .postComments) + endpoint,
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
