//
//  FeedsArticleViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 22/01/23.
//

import Foundation
import Foundation
import SwiftUI

class FeedArticleViewModel: ObservableObject {
    
    @Published var articleData: FeedArticle? = nil
    @Published var isLoading = true
    
    init() {
        getArticles()
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
    
    
    func updateSelectedFeedArticle (article: Article)  {
        if let row = articleData?.articles!.firstIndex(where: {$0.slug == article.slug}) {
            print("index at feed")
            articleData?.articles?[row] = article
        }
    }
}
