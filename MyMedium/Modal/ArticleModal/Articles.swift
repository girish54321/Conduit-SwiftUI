//
//  TrandingArticles.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import Foundation

// MARK: - TrandingArticles
struct TrandingArticles: Codable {
    var articles: [Article]?
    let articlesCount: Int?
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    var slug, title, description, body: String?
    var tagList: [String]?
    let favoritedBy: [FavoritedBy]?
    let createdAt, updatedAt: String?
    var favorited: Bool?
    let favoritesCount: Int?
    let author: Author?
}

// MARK: - FollowArticle
struct FavArticleRes: Codable {
    var article: Article?
}

// MARK: - Author
struct Author: Codable {
    let username: String?
    let bio: String?
    let image: String?
    var following: Bool?
}

// MARK: - FavoritedBy
struct FavoritedBy: Codable {
    let id: Int?
    let email: String?
    let username, password: String?
    let image: String?
    let bio: String?
    let demo: Bool?
}


// MARK: - FeedArticle
struct FeedArticle: Codable {
    var articles: [Article]?
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

struct ArticleListParams {
    var tag: String?
    var author: String?
    var favorited: String?
    var limit: String?
    var offset: String?
    
    func toDictionary() -> [String: Any] {
        let params = [
            "tag": tag,
            "author": author,
            "favorited": favorited,
            "limit": limit,
            "offset": offset
        ]
        return params.compactMapValues { $0 }
    }
}

// MARK: - ArticleTag
struct ArticleTag: Codable {
    var tags: [String]?
}

struct DummyData {
    
    let data =  Article(slug: "", title: "If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!", description: "Omnis perspiciatis qui quia commodi sequi modi. Nostrum quam aut cupiditate est facere omnis possimus. Tenetur similique nemo illo soluta molestias facere quo. Ipsam totam facilis delectus nihil quidem soluta vel est omnis", body: "Quia quo iste et aperiam voluptas consectetur a omnis et.\\nDolores et earum consequuntur sunt et.\\nEa nulla ab voluptatem dicta vel. Temporibus aut adipisci magnam aliquam eveniet nihil laudantium reprehenderit sit.\\nAspernatur cumque labore voluptates mollitia deleniti et. Quos pariatur tenetur.\\nQuasi omnis eveniet eos maiores esse magni possimus blanditiis.\\nQui incidunt sit quos consequa.", tagList: ["some","tags","for","testing"], favoritedBy: [], createdAt: "2022-12-09T13:46:24.264Z", updatedAt: "2022-12-09T13:46:24.264Z", favorited: true, favoritesCount: 2, author: Author(username: "Girish", bio: "My Bios is my bio", image: "", following: true))
    
    let autherData = Author(username: "samsung fan boy", bio: "best in the world", image: "https://avatars.githubusercontent.com/u/47414322?v=4")

}
