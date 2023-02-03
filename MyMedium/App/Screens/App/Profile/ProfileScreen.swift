//
//  ProfileScreen.swift
//  Conduit
//
//  Created by na on 17/01/23.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    @State private var showLogOutAlert = false
    
    var body: some View {
        NavigationStack (path: $profileStack.presentedScreen) {
            VStack {
                if authViewModel.isLoggedIn {
                    List {
                        ProfileView(profileImage: authViewModel.userState?.user?.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg", userName: authViewModel.userState?.user?.username ?? "username", bio: authViewModel.userState?.user?.bio ?? "Bio", email: authViewModel.userState?.user?.email ?? "Email", clicked: {
                            goToEditProfileScreen()
                        })
                        Section ("Article") {
                            if !authViewModel.isLoading {
                                VStack {
                                    ForEach(authViewModel.userArticle?.articles ?? [DummyData().data,DummyData().data]) { article in
                                        VStack {
                                            HStack {
                                                ArticleRow(article: article)
                                                    .padding(.bottom)
                                                Spacer()
                                            }
                                            Divider()
                                        }
                                        .onTapGesture {
                                            if (authViewModel.isLoading){
                                                return
                                            }
                                            let data = SelectedArticleScreenType(selectedArticle: article)
                                            profileStack.presentedScreen.append(data)
                                            articleViewModel.selectedArticle = article
                                        }
                                    }
                                }
                            } else {
                                LoadingForEachListing()
                            }
                        }
                    }
                    .refreshable {
                        authViewModel.getArticles(parameters: ArticleListParams(author:authViewModel.userState?.user?.username,limit: "50"))
                    }
                } else {
                    LoginPlaceHolder(title: "see Profile")
                }
                
            }
            .alert(isPresented: $showLogOutAlert) {
                Alert(title: Text("Log out?"),
                      message: Text("Are you sure you want to logout out? Press 'OK' to confirm or 'Cancel' to stay Logged in."),
                      primaryButton: .destructive(Text("Yes")) {
                    authViewModel.userState = nil
                    authViewModel.token = ""
                    authViewModel.isLoggedIn = false
                    isSkipped = false
                    token = ""
                }, secondaryButton: .cancel())
            }
            .navigationBarItems(
                trailing:
                    VStack{
                        if authViewModel.isLoggedIn {
                            Button(action: {
                                showLogOutAlert.toggle()
                            }) {
                                Text("Logout")
                            }
                        } else {
                            /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                        }
                    }
            )
            .onAppear {
                if (!authViewModel.isLoggedIn) {
                    return
                }
                authViewModel.getArticles(
                    parameters: ArticleListParams(author:authViewModel.userState?.user?.username,limit: "50")
                )
            }
            .navigationBarTitle("Profile")
            .navigationDestination(for: SelectedArticleScreenType.self) { type in
                ArticleDetailViewScreen(activeStack: .profile)
            }
            .navigationDestination(for: EditProfileScreenType.self) { type in
                EditProfileScreen(userparms: type.data)
            }
        }
        
    }
    
    func goToEditProfileScreen () {
        let data = UserUpdateParms(email: authViewModel.userState?.user?.email ?? "", password: "", username: authViewModel.userState?.user?.username ?? "", bio: authViewModel.userState?.user?.bio ?? "", image: authViewModel.userState?.user?.image ?? "")
        let screen = EditProfileScreenType(data: data)
        profileStack.presentedScreen.append(screen)
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
