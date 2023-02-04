//
//  HomeScreen.swift
//  Conduit
//
//  Created by na on 16/01/23.
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
            TradingArticleScreen()
                .tabItem {
                    Image(systemName: AppIconsSF.trandingIcon)
                    Text("Trading")
                }
            NavigationView {
                CreateArticleScreen(activeStack: .root)
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
        .onAppear{
            appViewModel.alertToast = AppMessage.loadingView
            appViewModel.show.toggle()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(AppViewModel())
    }
}
