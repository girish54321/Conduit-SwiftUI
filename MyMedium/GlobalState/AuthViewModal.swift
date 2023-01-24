//
//  AuthViewModal.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
class AuthViewModel: ObservableObject {
    
    @Published var isLogedin = false
    @Published var tokan: String? = nil
    @Published var userState: LoginScuccess? = nil
    @Published var userArticle: TrandingArticles? = nil
    @Published var isLoading: Bool = false
    
    init() {
        getProfile()
    }
    
    func saveUser(data:LoginScuccess)  {
        userState = data
    }
    
    func getArticles(parameters: ArticleListParams) {
        isLoading = true
        ArticleServices().getTrandingArticle(parameters: parameters.toDictionary()){
            result in
            switch result {
            case .success(let data):
                self.userArticle = data
                self.isLoading = false
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
    
    func getProfile() {
        AuthServices().getUser(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                self.userState = data
                self.isLogedin = true
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
}
