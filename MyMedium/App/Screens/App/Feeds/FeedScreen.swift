//
//  FeedScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI 
import Shimmer

struct FeedScreen: View {
    
    @EnvironmentObject var navStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var feedViewModel: FeedArticleViewModel
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                if !feedViewModel.isLoading {
                    List(feedViewModel.articleData?.articles ?? []) { article in
                        Button (action: {
                            let data = SelectedArticleScreenType(selectedArticle: article)
                            navStack.presentedScreen.append(data)
                            articleViewModel.selectedArticle = article
                        }, label: {
                            HStack {
                                ArticleRow(article: article)
                            }
                        })
                        .buttonStyle(.plain)
                    }
                    .refreshable {
                        feedViewModel.getArticles()
                    }
                    .navigationDestination(for: SelectedArticleScreenType.self) { type in
                        ArticleDetailViewScreen(isFeedStack: true)
                    }
                } else {
                    LoadingListing()
                }
            }
            .animation(.spring(), value: feedViewModel.isLoading)
            .navigationBarTitle("For You")
        }
    }
}

struct FeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
            .environmentObject(FeedNavigationStackViewModal())
            .environmentObject(AuthViewModel())
            .environmentObject(ArticleViewModel())
            .environmentObject(FeedArticleViewModel())
    }
}
