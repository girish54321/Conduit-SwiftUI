//
//  HomeScreen.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI
import AlertToast

struct HomeScreen: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
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
            NavigationView {
                CreateArticleScreen()
            }
            .tabItem {
                Image(systemName: AppIconsSF.profileIcon)
                Text("Add Post")
            }
            ProfileScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.userIcon)
                    Text("Profile")
                }
        }
        .alert(isPresented: $appViewModel.showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text(appViewModel.errorMessage))
        }
        .toast(isPresenting: $appViewModel.show){
            appViewModel.alertToast
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(AppViewModel())
    }
}
