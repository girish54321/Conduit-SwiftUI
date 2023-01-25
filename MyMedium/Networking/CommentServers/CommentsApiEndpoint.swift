//
//  CommentsApiEndpoint.swift
//  MyMedium
//
//  Created by Girish Parate on 23/01/23.
//

import Foundation
class CommentsApiEndpoint {
    
    enum CommentsApiType {
        case getComments
        case postComments
    }
    
    func createEndPoint(endPoint: CommentsApiType) -> String {
        switch endPoint {
        case .getComments:
            return createApi(endPoint: "articles/")
        case .postComments:
            return createApi(endPoint: "articles/")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
