//
//  TrandingArticles.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import Foundation

// MARK: - TrandingArticles
struct TrandingArticles: Codable {
    let articles: [Article]?
    let articlesCount: Int?
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    var slug, title, description, body: String?
    var tagList: [String]?
    let createdAt, updatedAt: String?
    let favorited: Bool?
    let favoritesCount: Int?
    let author: Author?
}

// MARK: - Author
struct Author: Codable {
    let username: String?
    let bio: String?
    let image: String?
    var following: Bool?
}


// MARK: - FeedArticle
struct FeedArticle: Codable {
    let articles: [Article]?
    let articlesCount: Int?
}

// MARK: - Create Article Modal AF
struct RequestParams {
    let article: ArticleParams
    func toDictionary() -> [String: Any] {
        return ["article": article.toDictionary()]
    }
}

struct ArticleParams {
    var title: String
    var description: String
    var body: String
    var tagList: [String]
    
    func toDictionary() -> [String: Any] {
        return [
            "title": title,
            "description": description,
            "body": body,
            "tagList": tagList
        ]
    }
}
