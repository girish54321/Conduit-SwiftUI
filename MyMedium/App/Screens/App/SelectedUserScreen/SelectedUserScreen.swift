//
//  SelectedUserScreen.swift
//  MyMedium
//
//  Created by Girish Parate on 24/01/23.
//

import SwiftUI 

struct SelectedUserScreen: View {
    @State var auther: Author
    @State private var selection: String? = nil
    @EnvironmentObject var profileViewModal: ProfileViewModel
    @State private var page: String? = nil
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @State var activeStack: AppNavStackType
    @EnvironmentObject var feedStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TrandingNavigationStackViewModal 
    
    var body: some View {
        List {
            ProfileView(profileImage: profileViewModal.selectedAuther.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg",
                        userName: profileViewModal.selectedAuther.username ?? "username",
                        bio: profileViewModal.selectedAuther.username ?? "Bio",
                        email: profileViewModal.selectedAuther.username ?? "Email"
            )
            Section ("articles") {
                if !profileViewModal.isLoading {
                    ForEach(profileViewModal.selectedUserArticle?.articles ?? []) { article in
                        VStack {
                            HStack {
                                ArticleRow(article: article)
                                    .padding(.bottom)
                                Spacer()
                            }
                        }
                        .onTapGesture {
                            articleViewModel.selectedArticle = article
                            if (activeStack == .feed){
                                feedStack.presentedScreen.removeLast()
                                return
                            }
                            if (activeStack == .article) {
                                articleStack.presentedScreen.removeLast()
                                return
                            }
                        }
                    }
                    .animation(.easeIn)
                } else {
                    LoadingForEarchListing()
                }
            }
        }
        .onAppear {
            profileViewModal.selectedAuther = auther
            profileViewModal.getSelectedAutherArticle(parameters: ArticleListParams(author:profileViewModal.selectedAuther.username))
        }
        .navigationBarTitle(profileViewModal.selectedAuther.username ?? "Na")
        .navigationDestination(for: SelectedArticleScreenType.self) { type in
            //            ArticleDetailViewScreen(isFeedStack: true)
        }
        
    }
}

struct SelectedUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SelectedUserScreen(auther:DummyData().autherData, activeStack: .article)
                .environmentObject(ProfileViewModel())
        }
    }
}
