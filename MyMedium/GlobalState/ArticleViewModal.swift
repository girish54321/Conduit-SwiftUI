//
//  ArticleViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
import SwiftUI

class ArticleViewModel: ObservableObject {
    @Published var tagList: ArticleTag? = nil
    @Published var articleData: TrandingArticles? = nil
    @Published var showFiltterScreen: Bool = false
    @Published var isLoading = true
    @Published var filtterParameters: ArticleListParams = ArticleListParams(limit: "50", offset: "0")
    
    init() {
        getArticles()
        getTags()
    }
    
    func createFiltter () {
        filtterParameters = ArticleListParams(limit: "50", offset: "0")
        getArticles()
    }
    
    func getTags() {
        ArticleServices().getTags(parameters: nil){
            result in
            switch result {
            case .success(let data):
                self.tagList = data
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
    
    func getArticles() {
        isLoading = true
        print(filtterParameters.toDictionary())
        ArticleServices().getTrandingArticle(parameters: filtterParameters.toDictionary()){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                self.articleData = data
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
