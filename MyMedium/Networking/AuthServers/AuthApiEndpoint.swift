//
//  AuthApiEndpoint.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
class AuthApiEndpoint {
    
    enum AuthApiType {
        case login
        case register
    }
    
    func createEndPoint(endPoint: AuthApiType) -> String {
        switch endPoint {
        case .login:
            return createApi(endPoint: "users/login")
        case .register:
            return createApi(endPoint: "users")
        }
    }
    
    func createApi(endPoint: String) -> String {
        return AppConst.ApiConst().apiEndPoint + endPoint
    }
}
