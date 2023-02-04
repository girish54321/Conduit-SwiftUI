//
//  ConduitApp.swift
//  Conduit
//
//  Created by na on 09/01/23.
//

import SwiftUI

@main
struct ConduitApp: App {
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    var body: some Scene {
        WindowGroup {
            if isSkipped == true || token != "" {
                HomeScreen()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
                    .environmentObject(FeedNavigationStackViewModal())
                    .environmentObject(TradingNavigationStackViewModal())
                    .environmentObject(ArticleViewModel())
                    .environmentObject(FeedArticleViewModel())
                    .environmentObject(CommentsViewModel())
                    .environmentObject(ProfileViewModel())
                    .environmentObject(ProfileNavigationStackViewModal())
            } else {
                WelcomeScreen()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
            }
        }
    }
}
