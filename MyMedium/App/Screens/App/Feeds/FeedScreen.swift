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
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var articleViewModel: FeedArticleViewModel
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                if !articleViewModel.isLoading {
                    List(articleViewModel.articleData?.articles ?? []) { article in
                        Button (action: {
                            let data = SelectedArticleScreenType(selectedArticle: article)
                            navStack.presentedScreen.append(data)
                        }, label: {
                            HStack {
                                ArticleRow(article: article)
                            }
                        })
                        .buttonStyle(.plain)
                    }
                    .refreshable {
                        articleViewModel.getArticles()
                    }
                    .navigationDestination(for: SelectedArticleScreenType.self) { type in
                        ArticleDetailViewScreen(article: type.selectedArticle!,isFeedStack: true)
                    }
                } else {
                    LoadingListing()
                }
            }
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
