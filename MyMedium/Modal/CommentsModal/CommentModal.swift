//
//  CommentModal.swift
//  MyMedium
//
//  Created by Girish Parate on 23/01/23.
//

import Foundation

// MARK: - CommentResponse
struct CommentListResponse: Codable {
    let comments: [Comment]?
}

struct CommentResponse: Codable {
    let comments: Comment?
}


// MARK: - Comment
struct Comment: Codable {
    let id: Int?
    let createdAt, updatedAt, body: String?
    let author: Author?
}
