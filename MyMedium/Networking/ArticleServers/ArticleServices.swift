//
//  ArticleServices.swift
//  MyMedium
//
//  Created by na on 16/01/23.
//

import Foundation
import Alamofire

class ArticleServices {
    
    func getTrendingArticle (
        parameters: Parameters?,
        completion: @escaping(Result<TrendingArticles,NetworkError>) -> Void){
            return RestAPIClient.request(type: TrendingArticles.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .getTrending),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getSignalArticle (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<updateArticleResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: updateArticleResponse.self,
                                         endPoint: "\(ArticleApiEndpoint().createEndPoint(endPoint: .getSignalArticle))\(endpoint)",
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getTags (
        parameters: Parameters?,
        completion: @escaping(Result<ArticleTag,NetworkError>) -> Void){
            return RestAPIClient.request(type: ArticleTag.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .getTags),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func getFeedArticle (
        parameters: Parameters?,
        completion: @escaping(Result<FeedArticle,NetworkError>) -> Void){
            return RestAPIClient.request(type: FeedArticle.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .feed),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func uploadArticle (
        parameters: Parameters?,
        completion: @escaping(Result<Article,NetworkError>) -> Void){
            return RestAPIClient.request(type: Article.self,
                                         endPoint: ArticleApiEndpoint().createEndPoint(endPoint: .uploadArticle),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    
    func updateArticle (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<updateArticleResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: updateArticleResponse.self,
                                         endPoint: "\(ArticleApiEndpoint().createEndPoint(endPoint: .updateArticle))\(endpoint)",
                                         method:.put,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func deleteAricle (
        parameters: Parameters?,
        endpoint: String,
        completion: @escaping(Result<String,NetworkError>) -> Void){
            return RestAPIClient.request(type: String.self,
                                         endPoint: "\(ArticleApiEndpoint().createEndPoint(endPoint: .deleteArticle))\(endpoint)",
                                         method:.delete,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
