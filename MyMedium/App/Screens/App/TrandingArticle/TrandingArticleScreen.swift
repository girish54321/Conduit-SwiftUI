//
//  TradingArticleScreen.swift
//  MyMedium
//
//  Created by na on 16/01/23.
//

import SwiftUI

struct TradingArticleScreen: View {
    
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var navStack: TradingNavigationStackViewModal
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            VStack {
                if !articleViewModel.isLoading {
                    List(articleViewModel.articleData?.articles ?? []) { article in
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
                        articleViewModel.getArticles()
                    }
                    .navigationDestination(for: SelectedArticleScreenType.self) { type in
                        ArticleDetailViewScreen(activeStack: .article)
                    }
                } else {
                    LoadingListing()
                }
            }
            .animation(.spring(), value: articleViewModel.isLoading)
            .sheet(isPresented: $articleViewModel.showFlitterScreen, content: {
                FlitterScreen()
            })
            .navigationBarTitle("Articles")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        articleViewModel.showFlitterScreen.toggle()
                    }) {
                        Image(systemName: "slider.below.rectangle")
                    }            )
        }
    }
    
    
    struct TradingArticleScreen_Previews: PreviewProvider {
        static var previews: some View {
            TradingArticleScreen()
                .environmentObject(TradingNavigationStackViewModal())
                .environmentObject(ArticleViewModel())
        }
    }
}
