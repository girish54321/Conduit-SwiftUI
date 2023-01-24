//
//  ProfileScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var navStack: ProfileNavigationStackViewModal
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    @State private var showLogOutAlert = false
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            List {
                ProfileView(profileImage: authViewModel.userState?.user?.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg", userName: authViewModel.userState?.user?.username ?? "username", bio: authViewModel.userState?.user?.bio ?? "Bio", email: authViewModel.userState?.user?.email ?? "Email")
                Section ("articlesss") {
                    if !authViewModel.isLoading {
                        VStack {
                            ForEach(authViewModel.userArticle?.articles ?? [DummyData().data,DummyData().data]) { article in
                                VStack {
                                    HStack {
                                        if !authViewModel.isLoading {
                                            ArticleRow(article: article)
                                                .padding(.bottom)
                                        } else {
                                            LoadingArticleItem(article: article)
                                        }
                                        Spacer()
                                    }
                                    Divider()
                                }
                                .onTapGesture {
                                    if (authViewModel.isLoading){
                                        return
                                    }
                                    let data = SelectedArticleScreenType(selectedArticle: article)
                                    navStack.presentedScreen.append(data)
                                    articleViewModel.selectedArticle = article
                                }
                            }
                            .animation(.easeIn)
                        }
                    } else {
                        LoadingForEarchListing()
                    }
                }
            }
            .refreshable {
                authViewModel.getArticles(parameters: ArticleListParams(author:authViewModel.userState?.user?.username,limit: "50"))
            }
            .alert(isPresented: $showLogOutAlert) {
                Alert(title: Text("Log out?"),
                      message: Text("Are you sure you want to delete this article?"),
                      primaryButton: .destructive(Text("Yes")) {
                    authViewModel.userState = nil
                    authViewModel.tokan = ""
                    authViewModel.isLogedin = false
                    isSkiped = false
                    tokan = ""
                }, secondaryButton: .cancel())
            }
            .navigationBarItems(
                trailing:
                    Button(action: {
                        showLogOutAlert.toggle()
                    }) {
                        Text("Logout")
                    }
            )
            .onAppear {
                authViewModel.getArticles(parameters: ArticleListParams(author:authViewModel.userState?.user?.username,limit: "50"))
            }
            .navigationBarTitle("Profile")
            .navigationDestination(for: SelectedArticleScreenType.self) { type in
                ArticleDetailViewScreen(isFeedStack: true)
            }
        }
    }
}


struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(AuthViewModel())
            .environmentObject(ProfileNavigationStackViewModal())
            .environmentObject(ArticleViewModel())
    }
}
