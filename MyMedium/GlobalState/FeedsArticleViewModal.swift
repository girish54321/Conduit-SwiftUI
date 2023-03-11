//
//  FeedsArticleViewModal.swift
//  Conduit
//
//  Created by Girish Parate on 22/01/23.
//

import Foundation
import Foundation
import SwiftUI

class FeedArticleViewModel: ObservableObject {
    
    @Published var articleData: FeedArticle? = FeedArticle(articles: [],articlesCount: 0)
    @Published var isLoading = true
    @Published var flitterParameters: ArticleListParams = ArticleListParams(limit: "10", offset: "0")
    
    init() {
        getArticles()
    }
    
    func getArticles() {
        print(flitterParameters.toDictionary())
        isLoading = true
        ArticleServices().getFeedArticle(parameters: flitterParameters.toDictionary()){
            result in
            self.isLoading = false
            switch result {
            case .success(let data):
                self.articleData?.articlesCount = data.articlesCount
                self.articleData?.articles?.append(contentsOf: data.articles!)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func reloadArticles () {
        flitterParameters = ArticleListParams(limit: "10", offset: "0")
        articleData = FeedArticle(articles: [],articlesCount: 0)
        getArticles()
    }
    
    
    func updateSelectedFeedArticle (article: Article)  {
        if let row = articleData?.articles!.firstIndex(where: {$0.slug == article.slug}) {
            articleData?.articles?[row] = article
        }
    }
}
