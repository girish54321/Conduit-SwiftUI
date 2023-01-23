//
//  ArticleViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
import SwiftUI
import AlertToast

class ArticleViewModel: ObservableObject {
    @Published var tagList: ArticleTag? = nil
    @Published var articleData: TrandingArticles? = nil
    @Published var showFiltterScreen: Bool = false
    @Published var isLoading = true
    @Published var filtterParameters: ArticleListParams = ArticleListParams(limit: "50", offset: "0")
    
    @Published var selectedArticle: Article = DummyData().data
    
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
    
    func bookMarkArticle (appViewModel: AppViewModel, feedViewModal: FeedArticleViewModel, isFeed: Bool) {
        FavoritesServices().bookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                print("bookMarkArticle")
                print(data.article?.favorited)
                appViewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Article Bookmark!")
                if(isFeed) {
                    self.selectedArticle.favorited = data.article?.favorited
                    if let row = feedViewModal.articleData?.articles!.firstIndex(where: {$0.slug == self.selectedArticle.slug}) {
                        feedViewModal.articleData?.articles?[row] = self.selectedArticle
                    }
                }
                self.selectedArticle.favorited = data.article?.favorited
                if let row = self.articleData?.articles!.firstIndex(where: {$0.slug == self.selectedArticle.slug}) {
                    self.articleData?.articles?[row] = self.selectedArticle
                }

            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
    
    
    func removeBookMarkArticle (appViewModel: AppViewModel, feedViewModal: FeedArticleViewModel, isFeed: Bool) {
        FavoritesServices().removeBookMarkArticle(parameters: nil, endpoint: "\(selectedArticle.slug ?? "")/favorite"){
            res in
            switch res {
            case .success(let data):
                print("removeBookMarkArticle")
                //                print(data.article?.favorited)
                appViewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Article Bookmark removed!")
                if(isFeed) {
                    self.selectedArticle.favorited = data.article?.favorited
                    if let row = feedViewModal.articleData?.articles!.firstIndex(where: {$0.slug == self.selectedArticle.slug}) {
                        feedViewModal.articleData?.articles?[row] = self.selectedArticle
                    }
                }
                self.selectedArticle.favorited = data.article?.favorited
                print(data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
