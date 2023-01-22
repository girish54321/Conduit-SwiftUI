//
//  MyMediumApp.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI

@main
struct MyMediumApp: App {
    
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    
    var body: some Scene {
        WindowGroup {
            if isSkiped == true || tokan != "" {
                HomeScreen()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
                    .environmentObject(FeedNavigationStackViewModal())
                    .environmentObject(TrandingNavigationStackViewModal())
                    .environmentObject(ArticleViewModel())
                    .environmentObject(FeedArticleViewModel())
            } else {
                WelcomeScreen()
                    .environmentObject(AppViewModel())
                    .environmentObject(AuthViewModel())
            }
        }
    }
}
