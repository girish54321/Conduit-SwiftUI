//
//  AuthModal.swift
//  MyMedium
//
//  Created by na on 11/01/23.
//

import Foundation
// MARK: - LoginSuccess
struct LoginSuccess: Codable {
    let user: User?
}

// MARK: - User
struct User: Codable {
    let email, token, username, bio: String?
    let image: String?
}

struct LoginFail: Codable {
    let error: String?
}

// MARK: - CreateAccountResponse
struct CreateAccountResponse: Codable {
    let id: Int?
    let token: String?
}
