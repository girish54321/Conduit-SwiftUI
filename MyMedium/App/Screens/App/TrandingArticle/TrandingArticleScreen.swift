//
//  TrandingArticleScreen.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI

struct TrandingArticleScreen: View {
    
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var navStack: TrandingNavigationStackViewModal
    
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
                        ArticleDetailViewScreen(article: type.selectedArticle!)
                    }
                } else {
                    LoadingListing()
                }
            }
            .sheet(isPresented: $articleViewModel.showFiltterScreen, content: {
                FiltterScreen()
            })
            .navigationBarTitle("Articles")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        articleViewModel.showFiltterScreen.toggle()
                    }) {
                        Image(systemName: AppIconsSF.editIcon)
                    }            )
        }
    }
    
    
    struct TrandingArticleScreen_Previews: PreviewProvider {
        static var previews: some View {
            TrandingArticleScreen()
                .environmentObject(TrandingNavigationStackViewModal())
                .environmentObject(ArticleViewModel())
        }
    }
}
