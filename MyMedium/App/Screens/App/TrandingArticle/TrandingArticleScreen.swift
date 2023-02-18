//
//  TradingArticleScreen.swift
//  Conduit
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
                AppListViewScreen(
                    forEach: {
                        LazyVStack {
                            ForEach(articleViewModel.articleData?.articles ?? []) { article in
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
                        }
                    }, headerView: {
                        
                    }, footerView: {
                        if articleViewModel.isLoading {
                            VStack {
                                LoadingArticleItem(article: DummyData().data)
                                LoadingArticleItem(article: DummyData().data)
                            }
                        }
                    }, onEndFuncation: {
                        if(articleViewModel.isLoading){
                            return
                        }
                        if (articleViewModel.articleData?.articlesCount ?? 0 <= articleViewModel.articleData?.articles?.count ?? 0){
                            print("no api call")
                            return
                        }
                        
                        articleViewModel.flitterParameters.offset = String(Int(articleViewModel.articleData?.articles?.count ?? 0))
                        articleViewModel.getArticles()
                    }, onReload: {
                        articleViewModel.reloadArticles()
                    })
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
                        Image(systemName: AppIconsSF.filtterIcon)
                    })
            .navigationDestination(for: SelectedArticleScreenType.self) { type in
                ArticleDetailViewScreen(activeStack: .article)
            }
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
