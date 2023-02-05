//
//  FeedScreen.swift
//  Conduit
//
//  Created by na on 17/01/23.
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
                    List {
                        Section {
                            ForEach(feedViewModel.articleData?.articles ?? []){ article in
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
                                .onAppear {
                                    if (feedViewModel.articleData?.articlesCount ?? 0 <= feedViewModel.articleData?.articles?.count ?? 0){
                                        print("no api call")
                                        return
                                    }
                                    if (article.id == feedViewModel.articleData?.articles?.last?.id){
                                        feedViewModel.flitterParameters.offset = String(Int(feedViewModel.articleData?.articles?.count ?? 0))
                                        feedViewModel.getArticles()
                                    }
                                }
                            }
                            if feedViewModel.isLoading {
                                VStack {
                                    LoadingArticleItem(article: DummyData().data)
                                    LoadingArticleItem(article: DummyData().data)
                                }
                            }
                        }
                    }
                    .refreshable {
                        feedViewModel.reloadArticles()
                    }
            }
            .animation(.spring(), value: feedViewModel.isLoading)
            .navigationDestination(for: SelectedArticleScreenType.self) { type in
                ArticleDetailViewScreen(activeStack:.feed)
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
