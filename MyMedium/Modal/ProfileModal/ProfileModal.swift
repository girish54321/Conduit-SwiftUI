//
//  ProfileModal.swift
//  Conduit
//
//  Created by na on 18/01/23.
//

import Foundation
// MARK: - FollowUser
struct FollowUser: Codable {
    let profile: Profile?
}

// MARK: - Profile
struct Profile: Codable {
    let username, bio, image: String?
    let following: Bool?
}
