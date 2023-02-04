//
//  AuthModal.swift
//  Conduit
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

struct UserAuthParams {
    var username: String?
    var email: String
    var password: String
    
    func toDictionary() -> [String: Any] {
        let params = ["username": username, "email": email, "password": password].compactMapValues { $0 }
        return ["user": params]
    }
}

struct UserUpdateParms: Codable {
    var email: String?
    var password: String?
    var username: String?
    var bio: String?
    var image: String
    
    func toDictionary() -> [String: Any] {
        let params = ["user": ["email": email, "password": password, "username": username, "bio": bio, "image": image].compactMapValues { $0 }]
        return params
    }
}
