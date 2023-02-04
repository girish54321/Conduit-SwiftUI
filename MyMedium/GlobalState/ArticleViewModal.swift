//
//  ArticleViewModal.swift
//  Conduit
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
import SwiftUI

class ArticleViewModel: ObservableObject {
    @Published var tagList: ArticleTag? = nil
    @Published var articleData: TrendingArticles? = nil
    @Published var showFlitterScreen: Bool = false
    @Published var isLoading = true
    @Published var flitterParameters: ArticleListParams = ArticleListParams(limit: "50", offset: "0")
    
    @Published var selectedArticle: Article = DummyData().data
    @Published var comments: CommentListResponse?
    init() {
        getArticles()
        getTags()
    }
    
    
    func getComments () {
        CommentsServices().getComments(parameters: nil,
                                       endpoint:
                selectedArticle.slug! + "/comments", completion: {
            res in
            switch res {
            case .success(let data):
                self.comments = data
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
        })
    }
    
    func createFlitter () {
        flitterParameters = ArticleListParams(limit: "50", offset: "0")
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
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func getArticles() {
        isLoading = true
        print(flitterParameters.toDictionary())
        print("WTF")
        ArticleServices().getTrendingArticle(parameters: flitterParameters.toDictionary()){
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
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func bookMarkArticle (onComplete: @escaping (Article?,String?) -> Void) {
        FavoritesServices().bookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                print("bookMarkArticle Done")
                onComplete(data.article!,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    onComplete(nil,errorMessage)
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
    
    func updateSelectedArticle (article: Article)  {
         self.selectedArticle = article
        if let row = articleData?.articles!.firstIndex(where: {$0.slug == self.selectedArticle.slug}) {
            print("index at news")
            articleData?.articles?[row] = article
        }
    }
    
    
    func removeBookMarkArticle (onComplete: @escaping (Article?,String?) -> Void) {
        FavoritesServices().removeBookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                print("removeBookMarkArticle")
                print(data)
                onComplete(data.article!,nil)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    onComplete(nil,errorMessage)
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
    
    func getSignalArticle()  {
        ArticleServices().getSignalArticle(parameters: nil, endpoint: selectedArticle.slug!, completion: { res in
            switch res {
            case .success(let data):
                print("getSignalArticle")
                self.selectedArticle = data.article!
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        })
    }
    
}
