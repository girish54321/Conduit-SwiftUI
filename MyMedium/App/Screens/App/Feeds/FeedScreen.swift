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
    @EnvironmentObject var articleViewModel: ArticleViewModel
    
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
                    .navigationDestination(for: SelectedArticleScreenType.self) { type in
                        ArticleDetailViewScreen(article: type.selectedArticle!,isFeedStack: true)
                    }
                } else {
                    LoadingListing()
                }
            }
            .navigationBarTitle("Feed")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        //                        showBottomSheet.toggle()
                    }) {
                        Image(systemName: AppIconsSF.editIcon)
                    }            )
            //            .sheet(isPresented: $showBottomSheet, content: {
            //                Filtter()
            //            })
            .onAppear {
                //            getProfile()
                            articleViewModel.getArticles()
            }
        }
        
    }
    
    func getProfile() {
        AuthServices().getUser(parameters: nil) {
            result in
            switch result {
            case .success(let data):
                authViewModel.userState = data
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
}

struct FeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
            .environmentObject(FeedNavigationStackViewModal())
            .environmentObject(AuthViewModel())
            .environmentObject(ArticleViewModel())
    }
}
