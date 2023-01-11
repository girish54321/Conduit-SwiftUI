//
//  NavModal.swift
//  MyMedium
//
//  Created by neosoft on 10/01/23.
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

