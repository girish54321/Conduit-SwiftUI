//
//  ProfileApiEndpoint.swift
//  MyMedium
//
//  Created by na on 18/01/23.
//

import Foundation
class ProfileApiEndpoint {
    
    enum ProfileApiType {
        case follow
    }
    
    func createEndPoint(endPoint: ProfileApiType) -> String {
        switch endPoint {
        case .follow:
            return createApi(endPoint: "profiles")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
