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
            ProfileView(profileImage: profileViewModal.selectedAuthor.image ?? AppConst.imagePath,
                        userName: profileViewModal.selectedAuthor.username ?? "username",
                        bio: profileViewModal.selectedAuthor.username ?? "Bio",
                        email: profileViewModal.selectedAuthor.username ?? "Email", clicked: nil
            )
                if !profileViewModal.isLoading {
                    ForEach(profileViewModal.selectedUserArticle?.articles ?? []) { article in
                        ArticleRow(article: article,withoutDivider: true)
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
