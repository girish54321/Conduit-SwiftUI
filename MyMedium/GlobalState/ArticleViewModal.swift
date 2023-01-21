//
//  ArticleViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
import SwiftUI

class ArticleViewModel: ObservableObject {
    
    @Published var articleData: FeedArticle? = nil
    @Published var showFiltterScreen = false
    @Published var isLoading = true
    
    init() {
//        getArticles()
    }
    
    func getArticles() {
        isLoading = true
        let parameters: [String: Any] = [
            "limit":"50",
        ]
        ArticleServices().getFeedArticle(parameters: parameters){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                withAnimation {
                    self.articleData = data
                }
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
