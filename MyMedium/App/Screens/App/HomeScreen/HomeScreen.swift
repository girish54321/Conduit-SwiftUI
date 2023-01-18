//
//  HomeScreen.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            FeedScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.homeIcon)
                    Text("For You")
                }
            TrandingArticleScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.trandingIcon)
                    Text("Tranding")
                }
            CreateArticleScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.profileIcon)
                    Text("Add Post")
                }
            ProfileScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.settingsIcon)
                    Text("Profile")
                }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
