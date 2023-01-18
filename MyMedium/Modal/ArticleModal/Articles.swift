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
    let slug, title, description, body: String?
    let tagList: [String]?
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
    let following: Bool?
}


// MARK: - FeedArticle
struct FeedArticle: Codable {
    let articles: [Article]?
    let articlesCount: Int?
}
