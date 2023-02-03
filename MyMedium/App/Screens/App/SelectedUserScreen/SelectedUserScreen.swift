//
//  SelectedUserScreen.swift
//  Conduit
//
//  Created by Girish Parate on 24/01/23.
//

import SwiftUI 

struct SelectedUserScreen: View {
    @State var author: Author
    @State private var selection: String? = nil
    @EnvironmentObject var profileViewModal: ProfileViewModel
    @State private var page: String? = nil
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @State var activeStack: AppNavStackType
    @EnvironmentObject var feedStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TradingNavigationStackViewModal
    
    var body: some View {
        List {
            ProfileView(profileImage: profileViewModal.selectedAuthor.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg",
                        userName: profileViewModal.selectedAuthor.username ?? "username",
                        bio: profileViewModal.selectedAuthor.username ?? "Bio",
                        email: profileViewModal.selectedAuthor.username ?? "Email", clicked: {}
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
                    LoadingForEachListing()
                }
            }
        }
        .onAppear {
            profileViewModal.selectedAuthor = author
            profileViewModal.selectedAuthorArticle(parameters: ArticleListParams(author:profileViewModal.selectedAuthor.username))
        }
        .navigationBarTitle(profileViewModal.selectedAuthor.username ?? "Na")
        .navigationDestination(for: SelectedArticleScreenType.self) { type in
            //            ArticleDetailViewScreen(isFeedStack: true)
        }
        
    }
}

struct SelectedUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SelectedUserScreen(author:DummyData().authorData, activeStack: .article)
                .environmentObject(ProfileViewModel())
        }
    }
}
