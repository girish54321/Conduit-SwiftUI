//
//  AuthServices.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
import Alamofire

class AuthServices {
    
    func userLogin (
        parameters: Parameters?,
        completion: @escaping(Result<LoginScuccess,NetworkError>) -> Void){
            return RestAPIClient.request(type: LoginScuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .login),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func createAccount (
        parameters: Parameters?,
        completion: @escaping(Result<CreateAccoutResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: CreateAccoutResponse.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .register),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getUser (
        parameters: Parameters?,
        completion: @escaping(Result<LoginScuccess,NetworkError>) -> Void){
            return RestAPIClient.request(type: LoginScuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .profile),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
