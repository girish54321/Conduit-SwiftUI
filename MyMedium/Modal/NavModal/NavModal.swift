//
//  NavModal.swift
//  Conduit
//
//  Created by na on 10/01/23.
//

import Foundation

struct WelcomeScreenType: Identifiable, Hashable {
    let id = UUID()
    let title: String
}

struct LoginScreenType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var isCreateAccount: Bool?
}

struct EditProfileScreenType: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: EditProfileScreenType, rhs: EditProfileScreenType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    let id = UUID()
    var data: UserUpdateParms
}

struct SelectedProfileScreenType: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: SelectedProfileScreenType, rhs: SelectedProfileScreenType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    let id = UUID()
    var author: Author
}

struct SelectedArticleScreenType: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: SelectedArticleScreenType, rhs: SelectedArticleScreenType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    let id = UUID()
    var selectedArticle : Article?
}

struct CreateArticleScreenType: Identifiable, Hashable {
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: CreateArticleScreenType, rhs: CreateArticleScreenType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    let id = UUID()
    var selectedArticle : Article?
}

enum AppNavStackType {
    case feed
    case article
    case profile
    case root
}
